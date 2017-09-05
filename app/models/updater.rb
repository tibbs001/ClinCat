class Updater

  def self.populate
    Y2010MeshTerm.populate_from_file
    Y2016MeshTerm.populate_from_file
    Y2016MeshHeading.populate_from_file

    AnalyzedMeshTerm.populate_from_file
    AnalyzedFreeTextTerm.populate_from_file
  end

end
