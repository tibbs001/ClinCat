class Updater

  def populate
    populate_mesh_tables
    populate_analyzed_mesh_term_tables
    populate_analyzed_free_text_tables
    reload_aact_data
    sanity_checks
  end

  def populate_mesh_tables
    # Load MeSH terms for 2010 & 2016
    con=ActiveRecord::Base.establish_connection.connection
    con.execute("truncate table y2010_mesh_terms")
    Y2010MeshTerm.populate_from_file
    con.execute("truncate table y2016_mesh_terms")
    Y2016MeshTerm.populate_from_file
    con.execute("truncate table y2016_mesh_headings")
    Y2016MeshHeading.populate_from_file
  end

  def populate_analyzed_mesh_term_tables
    con=ActiveRecord::Base.establish_connection.connection
    con.execute("truncate table analyzed_mesh_terms")
    con.execute("delete from categorized_terms where term_type='mesh'")

    file='csv/2010_analyzed_mesh_terms.xlsx'
    AnalyzedMeshTerm.populate_from_file(file,'2010')
    file='csv/2017_analyzed_mesh_terms.xlsx'
    AnalyzedMeshTerm.populate_from_file(file,'2017')
  end

  def populate_analyzed_free_text_tables
    con=ActiveRecord::Base.establish_connection.connection
    con.execute("truncate table analyzed_free_text_terms")
    con.execute("delete from categorized_terms where term_type='free'")

    file='csv/2010_analyzed_free_text_terms.xlsx'
    AnalyzedFreeTextTerm.populate_from_file(file,'2010')
    file='csv/2017_analyzed_free_text_terms.xlsx'
    AnalyzedFreeTextTerm.populate_from_file(file,'2017')
  end

  def reload_aact_data(dmp_file='/var/local/share/other/20170903_aact.dmp')
    db_name=ActiveRecord::Base.connection.current_database
    cmd="pg_restore -c -j 5 -v -h localhost -p 5432 -U #{ENV['DB_SUPER_USERNAME']} -d #{db_name} #{dmp_file}"
    system cmd
    con=ActiveRecord::Base.establish_connection.connection
    con.execute('grant SELECT on all tables in schema public to public')
    current_users.each{|user|
      con.execute("grant connect on database #{db_name} to #{user}")
    }
  end

  def sanity_checks
    errors=[]

    # Using a static copy of AACT db, so row counts don't change - we know what to expect.
    # Spot check tables count to confirm reload_aac_data probably worked.
    errors << "Study count expected: 253574. actual: #{Aact::Study.count}" if Aact::Study.count != 253574
    errors << "BaselineCount count expected: 78029. actual: #{Aact::BaselineCount.count}" if Aact::BaselineCount.count != 78029
    errors << "Outcome count expected: 204694. actual: #{Aact::Outcome.count}" if Aact::Outcome.count != 204694

    # Verify load of 2010 analyzed terms
    file_cnt=Rails.root.join('csv','2010_analyzed_mesh_terms.csv').readlines.size
    table_cnt=AnalyzedMeshTerm.where('year like ?','%2010%').count
    errors << "Number of 2010 MeSH analyzed expected: #{file_cnt}. actual: #{table_cnt}" if file_cnt != table_cnt

    # Verify load of 2017 analyzed terms
    file_cnt=Rails.root.join('csv','2017_analyzed_mesh_terms.csv').readlines.size
    table_cnt=AnalyzedMeshTerm.where('year like ?','%2017%').count
    errors << "Number of 2017 MeSH analyzed expected: #{file_cnt}. actual: #{table_cnt}" if file_cnt != table_cnt

    # Verify that we parsed thru the Y/N columns correctly
    con=ActiveRecord::Base.establish_connection.connection
    results=con.execute("select distinct clinical_category from categorized_terms where term_type='mesh' ")
    errors << "Number of MeSH Clinical Categories is wrong. Expected: 17 Actual: #{results.count}" if results.count != 17
    results=con.execute("select distinct clinical_category from categorized_terms where term_type='free' ")
    errors << "Number of Free-Text Clinical Categories is wrong. Expected: 21 Actual: #{results.count}" if results.count != 21
    results=con.execute("select count(*) from categorized_terms where clinical_category='HEPATOLOGY_SPECIFIC' ")
    errors << "Count for HEPATOLOGY_SPECIFIC is wrong. Expected: 135 Actual: #{results.first["count"]}" if results.first["count"].to_i != 135

    # Verify that we parsed thru the Y/N columns correctly
    results=con.execute("select distinct year_verification from analyzed_mesh_terms ")
    errors << "Year Verification looks wonky. Expected: 4 Actual: #{results.count}" if results.count != 3
  end

  def current_users
    # assumes these user accounts already exist.
    ['chisw001','pulmon','ctti']
  end

end
