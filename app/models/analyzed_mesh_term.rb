class AnalyzedMeshTerm < ActiveRecord::Base

  has_many :categorized_terms, :foreign_key => 'identifier', :dependent => :delete_all

  def self.populate_from_file(file_name, year)
    File.open(file_name).each_line{|line|
      return if line.blank?
      line_array=line.split('|')
      qualifier=line_array.first.split('.').first
      term=line_array[1].strip

      if !qualifier.nil? and qualifier.downcase != 'mesh_id'

        new(:qualifier=>qualifier,
            :identifier=>line_array.first,
            :downcase_term=>term.downcase,
            :term=>term,
            :year=>year,
            :year_verification=>get_year_verification(line_array, year)
        ).save
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
