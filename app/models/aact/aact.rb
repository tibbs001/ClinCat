class Aact < ActiveRecord::Base
  establish_connection(ENV["AACT_DATABASE_URL"])
  self.abstract_class = true
  after_initialize :readonly!
  belongs_to :study, :foreign_key=> 'nct_id'
end
