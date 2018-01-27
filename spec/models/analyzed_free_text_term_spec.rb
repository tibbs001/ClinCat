require 'rails_helper'

RSpec.describe AnalyzedFreeTextTerm, type: :model do
  context 'when loading free text terms' do

    it 'should create a pulmonary_2016 row when Y found in that column' do
      year='2010'
      sample_term='Deep Vein Thrombosis'
      AnalyzedFreeTextTerm.destroy_all
      CategorizedTerm.destroy_all
      file_name="spec/support/files/2010_analyzed_free_text_terms.xlsx"
      AnalyzedFreeTextTerm.populate_from_file(file_name, year)
      expect(CategorizedTerm.where('identifier=? and year = ? and category=?',sample_term, year, 'Cardiology').size).to eq(1)
      expect(CategorizedTerm.where('identifier=? and year = ? and category=?',sample_term, year, 'Cardiology').size).to eq(1)
      expect(CategorizedTerm.where('identifier=? and year = ? and category=?',sample_term, year, 'Pvd').size).to eq(1)
    end

    it 'should create a pulmonary_2016 row when Y found in that column' do
      year='2016'
      sample_term='Renal Transplantation'
      AnalyzedFreeTextTerm.destroy_all
      CategorizedTerm.destroy_all
      file_name="spec/support/files/2016_analyzed_free_text_terms.xlsx"
      AnalyzedFreeTextTerm.populate_from_file(file_name, year)
      expect(CategorizedTerm.where('identifier=? and year = ? and category=?', sample_term, year, 'Pulmonary_2016').size).to eq(1)
      expect(CategorizedTerm.where('identifier=? and year = ? and category=?', sample_term, year, 'Transplant_2016').size).to eq(1)
      expect(CategorizedTerm.where('category=? and year = ?','Pulmonary_2010', year).size).to eq(2)
      expect(CategorizedTerm.where('category=? and year = ?','Pulmonary_2016', year).size).to eq(5)
      expect(CategorizedTerm.where('category=? and year = ?','Transplant_2016', year).size).to eq(4)
      expect(CategorizedTerm.where('term_type=?','free').size).to eq(11)
    end

    it 'should create categorized_terms for both 2010 & 2016' do
      # -------------  2010
      year='2010'
      AnalyzedFreeTextTerm.destroy_all
      CategorizedTerm.destroy_all
      file_name="spec/support/files/2010_analyzed_free_text_terms.xlsx"
      AnalyzedFreeTextTerm.populate_from_file(file_name, year)

      # -------------  2016
      year='2016'
      file_name="spec/support/files/2016_analyzed_free_text_terms.xlsx"
      AnalyzedFreeTextTerm.populate_from_file(file_name, year)

      sample_term='Chronic Obstructive Pulmonary Disease'
      # Don't duplicate rows in AnalyzedFreeTextTerm.
      expect(AnalyzedFreeTextTerm.where('identifier=?', sample_term).size).to eq(1)
      expect(CategorizedTerm.where('identifier=? and year = ? and category=?', sample_term, year, 'Pulmonary_2016').size).to eq(1)
      expect(CategorizedTerm.where('identifier=? and year = ? and category=?', sample_term, '2010', 'Pulmonary_medicine').size).to eq(1)
      expect(CategorizedTerm.where('category=? and year = ?','Pulmonary_2016', year).size).to eq(5)
      a=AnalyzedFreeTextTerm.where('identifier=?', sample_term)
      expect(a.size).to eq(1)
      expect(a.first.term).to eq(sample_term)
      expect(CategorizedTerm.where('category=? and year = ?','Pulmonary_2016', year).size).to eq(5)
      expect(a.first.year).to eq('2010,2016')

      # -------------  2018
      year='2018'
      file_name="spec/support/files/2018_analyzed_free_text_terms.xlsx"
      AnalyzedFreeTextTerm.populate_from_file(file_name, year)
      sample_term='Adult Solid Neoplasm'
      rows=CategorizedTerm.where('identifier=? and year = ? and term_type=?', sample_term, year, 'free')
      expect(rows.size).to eq(21)
      rows=AnalyzedFreeTextTerm.where('identifier=? and year = ?', sample_term, year)
      expect(rows.size).to eq(1)
      expect(CategorizedTerm.where('identifier=? and year = ? and category=? and term_type=?', sample_term, year, 'Oncology_2017', 'free').size).to eq(1)

      sample_term='ulcers'
      rows=CategorizedTerm.where('identifier=? and year = ? and term_type=?', sample_term, year, 'free')
      expect(rows.size).to eq(0)

    end

  end

end
#SELECT * FROM analyzed_free_text_terms WHERE (downcase_term='deep vein thrombosis')
#<AnalyzedFreeTextTerm id: 517, identifier: "Deep Vein Thrombosis", term: "Deep Vein Thrombosis", downcase_term: "deep vein thrombosis", year: "2010", note: "">
#SELECT  * FROM analyzed_free_text_terms WHERE (downcase_term='deep vein thrombosis')
