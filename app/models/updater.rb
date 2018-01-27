class Updater

  attr_accessor :con, :pub_con

  def populate
#    reload_aact_data
    populate_mesh_tables
    populate_analyzed_mesh_term_tables
    populate_analyzed_free_text_tables
    sanity_checks
    dump_database
  end

  def populate_mesh_tables
    # Load MeSH terms for 2010 & 2016
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
    file='csv/2016_analyzed_mesh_terms.xlsx'
    AnalyzedMeshTerm.populate_from_file(file,'2016')
    file='csv/2018_analyzed_mesh_terms.xlsx'
    AnalyzedMeshTerm.populate_from_file(file,'2018')
  end

  def populate_analyzed_free_text_tables
    con=ActiveRecord::Base.establish_connection.connection
    con.execute("truncate table analyzed_free_text_terms")
    con.execute("delete from categorized_terms where term_type='free'")

    file='csv/2010_analyzed_free_text_terms.xlsx'
    AnalyzedFreeTextTerm.populate_from_file(file,'2010')
    file='csv/2016_analyzed_free_text_terms.xlsx'
    AnalyzedFreeTextTerm.populate_from_file(file,'2016')
    file='csv/2018_analyzed_free_text_terms.xlsx'
    AnalyzedFreeTextTerm.populate_from_file(file,'2018')
  end

  def reload_aact_data(dmp_file='/aact-files/other/aact_20170903.dmp')
    if Rails.env == 'production'
      host=ENV['CLINCAT_HOSTNAME_PROD']
    else
      host='localhost'
    end
    cmd="PGPASSWORD=#{ENV['CLINCAT_PASSWORD_PROD']} pg_restore -c -j 5 -v -h #{host} -p 5432 -U #{ENV['DB_SUPER_USERNAME']} -d #{db_name} #{dmp_file}"
    system cmd
    con=ActiveRecord::Base.establish_connection.connection
    con.execute('grant SELECT on all tables in schema public to public')
    current_users.each{|user|
      con.execute("grant connect on database #{db_name} to #{user}")
    }
  end

  def dump_database
    psql_file="/aact-files/other/ClinCat_#{Time.now.strftime("%Y%m%d_%H")}.psql"
    File.delete(psql_file) if File.exist?(psql_file)
    cmd="PGPASSWORD=#{ENV['DB_SUPER_PASSWORD']} pg_dump --no-owner --no-acl -h localhost -U #{ENV['DB_SUPER_USERNAME']} #{db_name} > #{psql_file}"
    system cmd
  end

  def restore_public_database

    # clear out previous content of public db
    pub_con.execute('DROP SCHEMA IF EXISTS public CASCADE')
    pub_con.execute('CREATE SCHEMA public')
    cmd="psql -h aact-db.ctti-clinicaltrials.org #{db_name} < #{psql_file} > /dev/null"
    system cmd
  end

  def db_name
    con.current_database
  end

  def pub_con
    @pub_con ||= ActiveRecord::Base.establish_connection(ENV["CLINCAT_PUBLIC_DATABASE_URL"]).connection
  end

  def con
    if Rails.env == 'test'
      @con ||= ActiveRecord::Base.establish_connection.connection
    else
      @con ||= ActiveRecord::Base.establish_connection(ENV["CLINCAT_LOCAL_DATABASE_URL"]).connection
    end
  end

  def sanity_checks
    errors=[]

    # Using a static copy of AACT db, so row counts don't change - we know what to expect.
    # Spot check tables count to confirm reload_aac_data probably worked.
    errors << "Study count expected: 253574. actual: #{Aact::Study.count}" if Aact::Study.count != 253574
    errors << "BaselineCount count expected: 78029. actual: #{Aact::BaselineCount.count}" if Aact::BaselineCount.count != 78029
    errors << "Outcome count expected: 204694. actual: #{Aact::Outcome.count}" if Aact::Outcome.count != 204694

    # Verify load of 2010 analyzed terms
    file='csv/2010_analyzed_mesh_terms.xlsx'
    file_cnt=Roo::Spreadsheet.open(file).count
    table_cnt=AnalyzedMeshTerm.where('year like ?','%2010%').count
    errors << "Number of 2010 MeSH analyzed expected: #{file_cnt}. actual: #{table_cnt}" if file_cnt != table_cnt

    # Verify load of 2016 analyzed terms
    file='csv/2016_analyzed_mesh_terms.xlsx'
    file_cnt=Roo::Spreadsheet.open(file).count
    table_cnt=AnalyzedMeshTerm.where('year like ?','%2016%').count
    errors << "Number of 2016 MeSH analyzed expected: #{file_cnt}. actual: #{table_cnt}" if file_cnt != table_cnt

    # Verify that we parsed thru the Y/N columns correctly
    con=ActiveRecord::Base.establish_connection.connection
    results=con.execute("select distinct category from categorized_terms where term_type='mesh' ")
    errors << "Number of MeSH Clinical Categories is wrong. Expected: 17 Actual: #{results.count}" if results.count != 17
    results=con.execute("select distinct category from categorized_terms where term_type='free' ")
    errors << "Number of Free-Text Clinical Categories is wrong. Expected: 21 Actual: #{results.count}" if results.count != 21
    results=con.execute("select count(*) from categorized_terms where category='HEPATOLOGY_SPECIFIC' ")
    errors << "Count for HEPATOLOGY_SPECIFIC is wrong. Expected: 135 Actual: #{results.first["count"]}" if results.first["count"].to_i != 135

    # Verify that we parsed thru the Y/N columns correctly
    results=con.execute("select distinct year from analyzed_mesh_terms ")
    errors << "Year Verification looks wonky. Expected: 4 Actual: #{results.count}" if results.count != 3
  end

  def current_users
    # assumes these user accounts already exist.
    ['aact','ctti']
  end

end
