class AnalyzedMeshTerm < ActiveRecord::Base

  has_many :categorized_terms, :foreign_key => 'identifier', :dependent => :delete_all
  self.primary_key = 'identifier'

  def self.populate_from_file(file, year)

    tabs=Roo::Spreadsheet.open(file)
    header=get_header(tabs)
    (2..tabs.last_row).each { |i|
      row = Hash[[header, tabs.row(i)].transpose]
      create_from(row, year)
    }
  end

  def self.get_header(tabs)
    result=[]
    header = tabs.first
    header.each{|h| result << ActionView::Base.full_sanitizer.sanitize(h).downcase}
    result
  end

  def self.create_from(row, year)
    t=row['mesh_term']
    t=row['term'] if t.nil?
    term=t.split.map(&:capitalize).join(' ').strip
    id=row['mesh_id'].try(:strip)
    id=row['identifier'].try(:strip) if id.nil?
    qualifier=id.split('.').first
    note=get_note(row, year)

    existing=where('identifier=?',id).first
    if !existing
      create({:identifier=>id,:qualifier=>qualifier,:term=>term,:downcase_term=>term.downcase,:year=>year,:note=>note})
    else
      case note
      when 'Both'
        existing.note=note
        existing.year="#{existing.year},#{year}"
      when 'Old only'
        existing.year='2010'
        existing.note='Old only'
      when 'New only'
        new_term=Y2016MeshTerm.where('tree_number=?',existing.identifier).first.try(:mesh_term)
        if new_term
          existing.note='MeSH term changed'
          existing.term=new_term
          existing.downcase_term=new_term.downcase
          existing.former_term=Y2010MeshTerm.where('tree_number=?',existing.identifier).first.try(:mesh_term)
        else
          existing.note="Problem:  This term should be in 2016 MeSH Thesaurus, but was not found"
        end
      end
      existing.save!
    end
    CategorizedTerm.create_for(row, year, 'mesh')
  end

  def self.get_note(row, year)
    return '' if year == '2010'
    val=row['note']
    val=row['compare'] if val.nil?
    return val
  end

end
