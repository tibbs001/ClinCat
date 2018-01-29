class SanityChecker

  attr_accessor :con, :errors
  $stdout.sync = true
  ActiveRecord::Base.logger.level = 1

  def errors
    @errors ||= []
  end

  def con
    if Rails.env == 'test'
      @con ||= ActiveRecord::Base.establish_connection.connection
    else
      @con ||= ActiveRecord::Base.establish_connection(ENV["CLINCAT_LOCAL_DATABASE_URL"]).connection
    end
  end

  def run

    # Using a static copy of AACT db, so row counts don't change - we know what to expect.
    # Spot check tables count to confirm reload_aac_data probably worked.
    record_error("Study count expected: 253574. actual: #{Aact::Study.count}") if Aact::Study.count != 253574
    print "."
    record_error("BaselineCount count expected: 78029. actual: #{Aact::BaselineCount.count}") if Aact::BaselineCount.count != 78029
    print "."
    record_error("Outcome count expected: 204694. actual: #{Aact::Outcome.count}") if Aact::Outcome.count != 204694
    print "."

    # Verify load of 2010 analyzed terms
    file='csv/2010_analyzed_mesh_terms.xlsx'
    # subtract 1 from the file count to eliminate the header
    file_cnt=(Roo::Spreadsheet.open(file).count - 1).to_i
    table_cnt=AnalyzedMeshTerm.where('year like ?','%2010%').count
    record_error("Number of 2010 MeSH analyzed expected: #{file_cnt}. actual: #{table_cnt}") if file_cnt != table_cnt
    print "."

    # Verify load of 2016 analyzed terms
    file='csv/2016_analyzed_mesh_terms.xlsx'
    # subtract 1 from the file count to eliminate the header
    file_cnt=(Roo::Spreadsheet.open(file).count - 1).to_i
    table_cnt=AnalyzedMeshTerm.where('year like ?','%2016%').count
    record_error("Number of 2016 MeSH analyzed expected: #{file_cnt}. actual: #{table_cnt}") if file_cnt != table_cnt
    print "."

    # Verify load of 2018 analyzed terms
    file='csv/2018_analyzed_mesh_terms.xlsx'
    # subtract 1 from the file count to eliminate the header
    file_cnt=(Roo::Spreadsheet.open(file).count - 1).to_i
    table_cnt=AnalyzedMeshTerm.where('year like ?','%2018%').count
    record_error("Number of 2018 MeSH analyzed expected: #{file_cnt}. actual: #{table_cnt}") if file_cnt != table_cnt
    print "."

    # Verify that we parsed thru the Y/N columns correctly
    con=ActiveRecord::Base.establish_connection.connection
    results=con.execute("select distinct category from categorized_terms where term_type='mesh' ")
    record_error("Number of MeSH Clinical Categories is wrong. Expected: 51 Actual: #{results.count}") if results.count != 51
    print "."
    results=con.execute("select distinct category from categorized_terms where term_type='free' ")
    record_error("Number of Free-Text Clinical Categories is wrong. Expected: 21 Actual: #{results.count}") if results.count != 21
    print "."
    # Verify that we got data from the last category columns
    results=con.execute("select count(*) from categorized_terms where category='Hepatology Specific' ")
    record_error("Count for Hepatology Specific is wrong. Expected: 135 Actual: #{results.first["count"]}") if results.first["count"].to_i != 135
    print "."
    p=CategorizedTerm.where('category=?','Penis')
    record_error("Count for Penis is wrong. Expected: 4 Actual: #{p.size}") if p.size != 4
    print "."

    entries=CategorizedTerm.where('category=? and term_type=?','Eye','mesh')
    record_error("Count for Eye is wrong. Expected: 15 Actual: #{entries.size}") if entries.size != 15
    print "."
    entries=CategorizedTerm.where('category=? and term_type=?','Eye','free')
    record_error("Count for Eye is wrong. Expected: 3 Actual: #{entries.size}") if entries.size != 3
    print "."

    entries=CategorizedTerm.where('category=?','Eye')
    entries.each{|entry|
      if !eye_identifiers.include? entry.identifier
        record_error("Unexpected term assigned to Eye category: #{entry.identifier}")
        print "."
      end
    }

    # Verify that we parsed thru the Y/N columns correctly
    results=con.execute("select distinct year from analyzed_mesh_terms ")
    record_error("Year Verification looks wonky. Expected: 4 Actual: #{results.count}") if results.count != 4
    print "."

    # Test use case: C06.405.249.411.184.290
    results=CategorizedTerm.where('identifier=?','C06.405.249.411.184.290')
    record_error("Expected: 5 entries for C06.405.249.411.184.290. Actual: #{results.count}") if results.count != 5
    print "."
    results=CategorizedTerm.where('identifier=? and year=?','C06.405.249.411.184.290','2010')
    record_error("Expected: 2 2010 entries for C06.405.249.411.184.290. Actual: #{results.count}") if results.count != 2
    print "."
    results=CategorizedTerm.where('identifier=? and year=? and category=?','C06.405.249.411.184.290','2010','Gi Hepatology')
    record_error("Expected: 1 2010 GI Hepatology entry for C06.405.249.411.184.290. Actual: #{results.count}") if results.count != 1
    print "."
    results=CategorizedTerm.where('identifier=? and year=?','C06.405.249.411.184.290','2018')
    record_error("Expected: 3 2018 entries for C06.405.249.411.184.290. Actual: #{results.count}") if results.count != 3
    print "."
    results=CategorizedTerm.where('identifier=? and year=? and category=?','C06.405.249.411.184.290','2018','Colorectum')
    record_error("Expected: 1 2018 Colorectum entry for C06.405.249.411.184.290. Actual: #{results.count}") if results.count != 1
    print "."
    results=CategorizedTerm.where('identifier=? and year=? and category=?','C06.405.249.411.184.290','2018','Oncology_2010')
    record_error("Expected: 1 2018 Oncology_2010 entry for C06.405.249.411.184.290. Actual: #{results.count}") if results.count != 1
    print "."
    results=CategorizedTerm.where('identifier=? and year=? and category=?','C06.405.249.411.184.290','2018','Oncology_2017')
    record_error("Expected: 1 2018 Oncology_2017 entry for C06.405.249.411.184.290. Actual: #{results.count}") if results.count != 1
    print "."

    results=CategorizedTerm.where('year like ? and term_type=? and category=?','%2018%','mesh','Oncology_2017')
    record_error("Unexpected number of 2018 MeSH Oncology_2017 rows") if results.count != 1485
    print "."

    # Display Errors
    puts ""
    puts "======================================================"
    errors.each{|e| puts e}
    puts "======================================================"
  end

  def eye_identifiers
    [
      'C04.557.465.625.600.725',
      'C04.557.470.670.725',
      'C04.557.580.625.600.725',
      'C04.588.364',
      'C04.588.364.818.760',
      'C04.588.364.978',
      'C04.588.364.978.223',
      'C11.319',
      'C11.319.475.760',
      'C11.319.494',
      'C11.319.494.198',
      'C11.768.717.760',
      'C11.941.160.238',
      'C11.941.855',
      'C11.941.855.198',
      'Uveal Melanoma',
      'Intraocular Lymphoma',
      'Intraocular Melanoma'
    ]
  end

  def record_error(msg)
    errors << msg
  end

end
