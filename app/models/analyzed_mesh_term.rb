class AnalyzedMeshTerm < ActiveRecord::Base

  has_many :categorized_terms, :foreign_key => 'identifier', :dependent => :delete_all

  def self.populate_from_file(file_name, year)
    File.open(file_name).each_line{|line|
      return if line.blank?
      line_array=line.split('|')
      qualifier=line_array.first.split('.').first
      term=line_array[1].strip
      verif_note=get_year_verification(line_array, year)

      if !qualifier.nil? and qualifier.downcase != 'mesh_id'
        id=line_array.first
        existing=where('identifier=?',id).first  if year != '2010'
        if existing
          if existing.year == '2010,2017' || existing.year == '2017,2017'
            existing.year_verification='Appears MeSH term changed since 2010'
            existing.term=Y2016MeshTerm.where('tree_number=?',existing.identifier).first.try(:mesh_term)
            existing.former_term=Y2010MeshTerm.where('tree_number=?',existing.identifier).first.try(:mesh_term)
          else
            existing.year="#{existing.year},#{year}" if verif_note != 'Old only'
            existing.year_verification=verif_note
          end
          existing.save!
        else
          new(:qualifier=>qualifier,
              :identifier=>id,
              :downcase_term=>term.downcase,
              :term=>term,
              :year=>year,
              :year_verification=>verif_note
          ).save
        end
        CategorizedTerm.create_for(line_array, year, 'mesh')
      end
    }
  end

  def self.get_year_verification(line, year)
    return nil if year == '2010'
    val=line.last.gsub(/\n/,"").gsub(/\r/,"").strip
    return val if val == 'New only' || val == 'Old only' or val == 'Both'
  end

end
