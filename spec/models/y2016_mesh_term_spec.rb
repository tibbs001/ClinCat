require 'rails_helper'

RSpec.describe Y2016MeshTerm, type: :model do
  context 'when loading 2016 MeSH terms' do

    it 'should create a row for each incoming line in the file & not duplicate rows' do
      file_name="spec/support/files/2016_mesh_terms.csv"
      Y2016MeshTerm.populate_from_file(file_name)
      expect(Y2016MeshTerm.count).to eq(42)
      #verify no duplication
      Y2016MeshTerm.populate_from_file(file_name)
      expect(Y2016MeshTerm.count).to eq(42)
    end

  end

end
