class AnalyzedMeshTerm < ActiveRecord::Base

  def self.populate_from_file(file_name, year)
    puts "about to populate table of analyzed mesh terms..."
    contents=File.open(file_name)
    contents.each_line{|line|
      line_array=line.split('|')
      qualifier=line_array.first.split('.').first
      term=line_array[1].strip

      if !qualifier.nil? and qualifier != 'MESH_ID'

        new(:qualifier=>qualifier,
            :identifier=>line_array.first,
            :downcase_term=>term.downcase,
            :term=>term,
            :year=>year,
        ).save
        CategorizedTerm.create_for(line_array, year, 'mesh')
      end
    }
  end

end
