require 'rails_helper'

RSpec.describe AnalyzedFreeTextTerm, type: :model do
  context 'when loading free text terms' do

    it 'should create a pulmonary_2016 row when Y found in that column' do
      year='2017'
      sample_term='Renal Transplantation'
      AnalyzedFreeTextTerm.destroy_all
      CategorizedTerm.destroy_all
      file_name="spec/support/files/2017_analyzed_free_text_terms.xlsx"
      AnalyzedFreeTextTerm.populate_from_file(file_name, year)
      expect(CategorizedTerm.where('identifier=? and year = ? and category=?','Renal Transplantation', year, 'Pulmonary_2016').size).to eq(1)
      expect(CategorizedTerm.where('identifier=? and year = ? and category=?','Renal Transplantation', year, 'Transplant_2016').size).to eq(1)
      expect(CategorizedTerm.where('category=? and year = ?','Pulmonary_2016', year).size).to eq(4)
      expect(CategorizedTerm.where('category=? and year = ?','Transplant_2016', year).size).to eq(3)
      expect(CategorizedTerm.where('term_type=?','free').size).to eq(8)
    end
  end

end
