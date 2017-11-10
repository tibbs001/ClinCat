class AnalyzedFreeTextTerm < ActiveRecord::Base

  has_many :categorized_terms, :foreign_key => 'identifier', :dependent => :delete_all

  def self.populate_from_file(file_name, year)
    File.open(file_name).each_line{|line|
      return if line.blank?
      line_array=line.split('|')
      term=line_array[0].split.map(&:capitalize).join(' ').strip

      if !term.nil? and term.downcase != 'condition'
        new(:term=>term,
            :downcase_term=>term.downcase,
            :year=>year,
            :year_verification=>get_year_verification(line_array, year)
        ).save

        CategorizedTerm.create_for(line_array, year, 'free')

      end
    }
  end

  def self.get_year_verification(line, year)
    return nil if year == '2010'
    val=line.last.gsub(/\n/,"").gsub(/\r/,"").strip
    return val if val == 'New only' || val == 'Old only' or val == 'Both'
  end

end
