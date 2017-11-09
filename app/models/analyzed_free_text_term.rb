class AnalyzedFreeTextTerm < ActiveRecord::Base

  has_many :categorized_terms, :foreign_key => 'identifier', :dependent => :delete_all

  def self.populate_from_file(file_name, year)
    File.open(file_name).each_line{|line|
      line_array=line.split('|')
      term=line_array[0].split.map(&:capitalize).join(' ').strip

      if !term.nil? and term != 'CONDITION'
        new(:term=>term,
            :downcase_term=>term.downcase,
            :year=>year,
        ).save

        CategorizedTerm.create_for(line_array, year, 'free')

      end
    }

  end

end
