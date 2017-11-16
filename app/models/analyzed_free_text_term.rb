class AnalyzedFreeTextTerm < ActiveRecord::Base

  has_many :categorized_terms, :foreign_key => 'identifier', :dependent => :delete_all

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
    t=row['name']
    t=row['term'] if t.nil?
    t=row['condition'] if t.nil?
    term=t.split.map(&:capitalize).join(' ').strip
    row['identifier']=term  # Free text don't have identifiers - need to use the term itself as an ID
    note=get_note(row, year)

    existing=where('term=?',term).first  if year != '2010'
    if existing && existing.note != 'Old only'
      existing.year="#{existing.year},#{year}"
      existing.note=get_note(row, year)
      existing.save!
    else
      new(:term=>term,
          :identifier=>row['identifier'],
          :downcase_term=>term.downcase,
          :year=>year,
          :note=>get_note(row, year)
      ).save
    end
    CategorizedTerm.create_for(row, year, 'free')
  end

  def self.get_note(row, year)
    return '' if year == '2010'
    val=row['note']
    val=row['compare'] if val.nil?
  end

end
