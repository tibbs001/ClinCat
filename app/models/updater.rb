class Updater

  attr_accessor :con, :pub_con

  def run
    reload_aact_data
    populate_mesh_tables
    populate_analyzed_mesh_term_tables
    populate_analyzed_free_text_tables
    sanity_check
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
    file='csv/2017_analyzed_mesh_terms.xlsx'
    AnalyzedMeshTerm.populate_from_file(file,'2017')
  end

  def populate_analyzed_free_text_tables
    con=ActiveRecord::Base.establish_connection.connection
    con.execute("truncate table analyzed_free_text_terms")
    con.execute("delete from categorized_terms where term_type='free'")

    file='csv/2010_analyzed_free_text_terms.xlsx'
    AnalyzedFreeTextTerm.populate_from_file(file,'2010')
    file='csv/2016_analyzed_free_text_terms.xlsx'
    AnalyzedFreeTextTerm.populate_from_file(file,'2016')
    file='csv/2017_analyzed_free_text_terms.xlsx'
    AnalyzedFreeTextTerm.populate_from_file(file,'2017')
  end

  def reload_aact_data(dmp_file='/aact-files/other/aact_20170903.dmp')
    cmd="PGPASSWORD=#{ENV['CLINCAT_PASSWORD']} pg_restore -c -j 5 -v -h localhost -p 5432 -U #{ENV['DB_SUPER_USERNAME']} -d #{db_name} #{dmp_file}"
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
    @con ||= ActiveRecord::Base.establish_connection.connection
  end

  def sanity_check
    SanityChecker.new.run
  end

  def current_users
    # assumes these user accounts already exist.
    ['aact','ctti']
  end

end
