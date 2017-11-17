require 'rails_helper'

RSpec.describe AnalyzedMeshTerm, type: :model do
  context 'when loading mesh terms' do

    it 'should create a hepatology_specific row when Y found in that column' do
      year='2010'
      sample_identifier='C02.256.430.400'
      AnalyzedMeshTerm.destroy_all
      CategorizedTerm.destroy_all
      category='Hepatology Specific'
      file_name="spec/support/files/#{category.downcase}.xlsx"
      AnalyzedMeshTerm.populate_from_file(file_name, year)
      expect(CategorizedTerm.where('category=? and year = ?',category, year).size).to eq(2)
      amt=AnalyzedMeshTerm.where('identifier=? and year = ?',sample_identifier, year).first
      expect(amt.term).to eq('Hepatitis B')
      expect(amt.qualifier).to eq('C02')
    end

    it 'should create a cardiology row' do
      year='2010'
      AnalyzedMeshTerm.destroy_all
      CategorizedTerm.destroy_all
      category='cardiology'
      file_name="spec/support/files/#{category}.xlsx"
      AnalyzedMeshTerm.populate_from_file(file_name, year)
      cat=category.split.map(&:capitalize).join(' ').strip
      expect(CategorizedTerm.where('category=? and year = ?', cat, year).size).to eq(1)
      expect(CategorizedTerm.where('category=? and year = ?', 'Oncology', year).size).to eq(1)
      expect(AnalyzedMeshTerm.count).to eq(1)
      expect(CategorizedTerm.count).to eq(3)
    end

  end

  context 'loading 2010 & 2016 analyzed MeSH terms' do

    it "should save only 2010 if the note says 'Old only'" do
      AnalyzedMeshTerm.destroy_all
      CategorizedTerm.destroy_all
      file="spec/support/files/2010_analyzed_mesh_terms.xlsx"
      AnalyzedMeshTerm.populate_from_file(file,'2010')
      file="spec/support/files/2016_analyzed_mesh_terms.xlsx"
      AnalyzedMeshTerm.populate_from_file(file,'2016')
      id='G12.425.901.402'
      amt=AnalyzedMeshTerm.where("identifier=?",id).first
      expect(amt.categorized_terms.size).to eq(4)
      expect(CategorizedTerm.where("identifier=? and category=?",id,'Pulmonary Medicine').size).to eq(1)
      expect(CategorizedTerm.where("identifier=? and category=?",id,'Pulmonary_2016').size).to eq(1)
      expect(CategorizedTerm.where("identifier=? and category=?",id,'Transplant_2016').size).to eq(1)
      expect(amt.year).to eq('2010,2016')
      expect(amt.term).to eq('A Pulmonary Term')
      expect(amt.former_term).to be(nil)
    end

    it "should detect MeSH terms that have changed" do
      # Load MeSH terms into lookup tables
      Y2010MeshTerm.destroy_all
      Y2016MeshTerm.destroy_all
      Y2010MeshTerm.populate_from_file('spec/support/files/2010_mesh_terms.csv')
      Y2016MeshTerm.populate_from_file('spec/support/files/2016_mesh_terms.csv')

      AnalyzedMeshTerm.destroy_all
      CategorizedTerm.destroy_all
      id='C23.888.592.604.646'
      file="spec/support/files/2010_analyzed_mesh_terms.xlsx"
      AnalyzedMeshTerm.populate_from_file(file,'2010')
      amt=AnalyzedMeshTerm.where("identifier=?",id).first
      expect(amt.term).to eq('Mental Retardation')

      file="spec/support/files/2016_analyzed_mesh_terms.xlsx"
      AnalyzedMeshTerm.populate_from_file(file,'2016')
      amt=AnalyzedMeshTerm.where("identifier=?",id).first
      expect(amt.term).to eq('Intellectual Disability')
      expect(amt.former_term).to eq('Mental Retardation')
      expect(amt.note).to eq('Appears MeSH term changed since 2010')
    end

  end

  context 'loading 2016 analyzed terms' do

    it 'should create appropriate categorized terms' do
      AnalyzedMeshTerm.destroy_all
      CategorizedTerm.destroy_all
      file="spec/support/files/2016_analyzed_mesh_terms.xlsx"
      AnalyzedMeshTerm.populate_from_file(file,'2016')
      id="C01.539.757.360.150"
      amt=AnalyzedMeshTerm.where("identifier=?",id).first
      cat=CategorizedTerm.where("identifier=?",id).first
      expect(amt.term).to eq('Candidemia')
      expect(cat.category).to eq('Pulmonary_2016')
      id='E02.870.500'
      amt=AnalyzedMeshTerm.where("identifier=?",id).first
      expect(amt.term).to eq('Kidney Transplantation')
      cat=CategorizedTerm.where("identifier=?",id)
      expect(CategorizedTerm.where("identifier=? and category=?",id,'Pulmonary_2010').size).to eq(1)
      expect(CategorizedTerm.where("identifier=? and category=?",id,'Pulmonary_2016').size).to eq(1)
      expect(CategorizedTerm.where("identifier=? and category=?",id,'Transplant_2016').size).to eq(1)
      expect(cat.size).to eq(3)
      id='C01.539.757.800'
      amt=AnalyzedMeshTerm.where("identifier=?",id).first
      expect(amt.term).to eq('Shock, Septic')
      cat=CategorizedTerm.where("identifier=?",id)
      expect(cat.size).to eq(2)
    end
  end

end
