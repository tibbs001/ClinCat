module Aact
  class DesignGroup < StudyRelationship
    has_many :design_group_interventions,  inverse_of: :design_group
    has_many :interventions, :through => :design_group_interventions
  end
end

