require 'rails_helper'

RSpec.describe AnalyzedMeshTerm, type: :model do
  context 'when hepatoloy_specific term loaded' do

    it 'should create a hepatology_specific row' do
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

end
