require 'rails_helper'

RSpec.describe Y2010MeshTerm, type: :model do
  context 'when loading 2010 MeSH terms' do

    it 'should create a row for each incoming line in the file & not duplicate rows' do
      file_name="spec/support/files/2010_mesh_terms.csv"
      Y2010MeshTerm.populate_from_file(file_name)
      expect(Y2010MeshTerm.count).to eq(32)
      #verify no duplication
      Y2010MeshTerm.populate_from_file(file_name)
      expect(Y2010MeshTerm.count).to eq(32)
    end

  end

end
