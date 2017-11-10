class Updater

  def populate
    populate_mesh_tables
    populate_2010_analysis_tables
    populate_2017_analysis_tables
    reload_aact_data
  end

  def populate_mesh_tables
    # Load MeSH terms for 2010 & 2016
    Y2010MeshTerm.populate_from_file
    Y2016MeshTerm.populate_from_file
    Y2016MeshHeading.populate_from_file
  end

  def populate_2010_analysis_tables
    # Load term analysis for 2010
    file=Rails.root.join('csv','2010_analyzed_mesh_terms.csv')
    AnalyzedMeshTerm.populate_from_file(file,'2010')
    file=Rails.root.join('csv','2010_analyzed_free_text_terms.csv')
    AnalyzedFreeTextTerm.populate_from_file(file,'2010')
  end

  def populate_2017_analysis_tables
    # Load term analysis for 2017
    file=Rails.root.join('csv','2017_analyzed_mesh_terms.csv')
    AnalyzedMeshTerm.populate_from_file(file,'2017')
    file=Rails.root.join('csv','2017_analyzed_free_text_terms.csv')
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

  end

  def current_users
    # assumes these user accounts already exist.
    ['chisw001','pulmon','ctti']
  end

end
