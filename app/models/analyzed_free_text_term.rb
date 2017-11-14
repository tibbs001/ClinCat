class AnalyzedFreeTextTerm < ActiveRecord::Base

  has_many :categorized_terms, :foreign_key => 'identifier', :dependent => :delete_all
  self.primary_key = 'identifier'

  def self.populate_from_file(file_name, year)
    File.open(file_name).each_line{|line|
      return if line.blank?
      line_array=line.split('|')
      term=line_array[0].split.map(&:capitalize).join(' ').strip
      if !term.nil? and term.downcase != 'condition'
        existing=where('term=?',term).first  if year != '2010'
        if existing  && existing.note != 'Old only'
          existing.year="#{existing.year},#{year}"
          existing.note=get_note(line_array, year)
          existing.save!
        else
          new(:term=>term,
              :downcase_term=>term.downcase,
              :year=>year,
              :note=>get_note(line_array, year)
          ).save
        end
        CategorizedTerm.create_for(line_array, year, 'free')
      end
    }
  end

  def self.get_note(line, year)
    return nil if year == '2010'
    val=line.last.gsub(/\n/,"").gsub(/\r/,"").strip
    return val if val == 'New only' || val == 'Old only' or val == 'Both'
  end

end
