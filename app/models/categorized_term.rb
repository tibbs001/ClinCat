class CategorizedTerm < ActiveRecord::Base

  belongs_to :analyzed_mesh_term, :foreign_key => 'identifier'
  #belongs_to :analyzed_free_text_term, :foreign_key => 'identifier'

  def self.create_for(line, year, term_type)

    start_point=1 if term_type == 'free'
    start_point=2 if term_type == 'mesh'
    (start_point..line.size).each{|i|
      if line[i] && line[i].gsub(/\n/,"")=='Y'
        cat=ClinicalCategory.get_category_for(year, i, term_type)
        new(
          :identifier=>line.first,
          :clinical_category=>cat,
          :term_type=>term_type,
          :year=>year
        ).save!
      end
    }
  end

end
