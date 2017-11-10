require 'rails_helper'

RSpec.describe AnalyzedFreeTextTerm, type: :model do
  context 'when loading free text terms' do

    it 'should create a row in Categorized_Terms when Y found in that column' do
      year='2010'
      sample_term='Vascular Disease'
      AnalyzedFreeTextTerm.destroy_all
      CategorizedTerm.destroy_all
      category='CARDIOLOGY'
      file_name="spec/support/files/#{category.downcase}_free_text_terms.csv"
      AnalyzedFreeTextTerm.populate_from_file(file_name, year)
      expect(CategorizedTerm.count).to eq(8)
      expect(CategorizedTerm.where('clinical_category=? and year = ?',category, year).size).to eq(4)
      amt=AnalyzedFreeTextTerm.where('term=? and year = ?',sample_term, year)
      expect(amt.size).to eq(1)
    end

    it 'should create a pulmonary row when Y found in that column' do
      year='2017'
      sample_term='Renal Transplant'
      AnalyzedFreeTextTerm.destroy_all
      CategorizedTerm.destroy_all
      category='CARDIOLOGY'
      file_name="spec/support/files/#{category.downcase}_free_text_terms.csv"
      AnalyzedFreeTextTerm.populate_from_file(file_name, year)
      expect(CategorizedTerm.count).to eq(8)
    end
  end

end
