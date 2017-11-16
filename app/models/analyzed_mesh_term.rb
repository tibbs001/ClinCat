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
    id=row['mesh_id']
    id=row['identifier'] if id.nil?
    qualifier=id.split('.').first
    note=get_note(row, year)

    existing=where('identifier=?',id).first
    if existing
      if existing.year == '2010,2017' || existing.year == '2017,2010'
        existing.note='Appears MeSH term changed since 2010'
        existing.term=Y2016MeshTerm.where('tree_number=?',existing.identifier).first.try(:mesh_term)
        existing.former_term=Y2010MeshTerm.where('tree_number=?',existing.identifier).first.try(:mesh_term)
      else
        existing.year="#{existing.year},#{year}"
        if existing.note.blank?
          existing.note=note
        else
          existing.note="#{existing.note}, #{note}"
        end
        existing.save!
      end
    else
      create({:identifier=>id,:qualifier=>qualifier,:term=>term,:downcase_term=>term.downcase,:year=>year})
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
