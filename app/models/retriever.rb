class Retriever

  def self.run
    MeshTerm.populate_from_file
    OldMeshTerm.populate_from_file
    OldFreeTextTerm.populate_from_file
  end

  def self.get_study(nct_id)
    Aact::Study.find(nct_id)
  end

  def self.get(value=nil)
    col=[]
    return col if value.blank?
    case
    when value.downcase.match(/^nct/)
      study=Aact::Study.find(value) # They appear to be searching by the NCT ID
      col << study if study
    when !value.blank?
      # Search by Word or Phrase
      col=Aact::Study.find_by_term(value).uniq
      col << Tag.where('value=?',value).collect{|t|t.study}
    end
    col.flatten
  end

end
