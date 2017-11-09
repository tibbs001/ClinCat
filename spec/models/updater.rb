require 'rails_helper'

RSpec.describe Updater, type: :model do
  context 'restoring the database from a dump file' do

    xit 'should result in predictable number of studies' do
      file_name="spec/support/files/20170903_aact.dmp"
      updater=Updater.new
      allow(updater).to receive(:current_users).and_return(['ctti'])
      updater.reload_aact_data(file_name)
      expect(Study.count).to eq(2)
    end

  end

end
