class CategorizedTerm < ActiveRecord::Base

  def self.create_for(line, year, term_type)

    (2..line.size).each{|i|
      if line[i] && line[i].gsub(/\n/,"")=='Y'
        new(
          :identifier=>line.first,
          :clinical_category=>ClinicalCategory.get_category_for(year, i, term_type),
          :term_type=>term_type,
          :year=>year
        ).save!
      end
    }
  end

end
