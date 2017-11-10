module Aact
  class StudyRelationship < ActiveRecord::Base
    self.abstract_class = true
    after_initialize :readonly!
    belongs_to :study, :foreign_key=> 'nct_id'
  end
end
