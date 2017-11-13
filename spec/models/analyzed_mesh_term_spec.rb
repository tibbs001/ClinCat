require 'rails_helper'

RSpec.describe AnalyzedMeshTerm, type: :model do
  context 'when loading mesh terms' do

    it 'should create a hepatology_specific row when Y found in that column' do
      year='2010'
      sample_identifier='C02.256.430.400'
      AnalyzedMeshTerm.destroy_all
      CategorizedTerm.destroy_all
      category='HEPATOLOGY_SPECIFIC'
      file_name="spec/support/files/#{category.downcase}_mesh_terms.csv"
      AnalyzedMeshTerm.populate_from_file(file_name, year)
      expect(CategorizedTerm.where('clinical_category=? and year = ?',category, year).size).to eq(3)
      amt=AnalyzedMeshTerm.where('identifier=? and year = ?',sample_identifier, year).first
      expect(amt.term).to eq('Hepatitis B')
      expect(amt.qualifier).to eq('C02')
    end

    it 'should create a cardiology row' do
      year='2010'
      AnalyzedMeshTerm.destroy_all
      CategorizedTerm.destroy_all
      category='CARDIOLOGY'
      file_name="spec/support/files/#{category.downcase}_mesh_terms.csv"
      AnalyzedMeshTerm.populate_from_file(file_name, year)
      expect(CategorizedTerm.where('clinical_category=? and year = ?',category,year).size).to eq(2)
    end

  end

  context 'loading 2017 analyzed terms' do

    it 'should create appropriate categorized terms' do
      AnalyzedMeshTerm.destroy_all
      CategorizedTerm.destroy_all
      file="spec/support/files/2017_analyzed_mesh_terms.csv"
      AnalyzedMeshTerm.populate_from_file(file,'2017')
      amt=AnalyzedMeshTerm.where("identifier=?","C01.252.100.375").first
      cat=CategorizedTerm.where("identifier=?","C01.252.100.375").first
      expect(amt.term).to eq('Hemorrhagic Septicemia')
      expect(cat.clinical_category).to eq('PULMONARY')

      #expect(amt.categorized_terms.size).to eq(1)
      #pulmonary=amt.categorized_terms.select{|x|x.clinical_category=='PULMONARY'}
      #transplant=amt.categorized_terms.select{|x|x.clinical_category=='TRANSPLANT'}
      #expect(transplant).to be([])
    end
  end

end
