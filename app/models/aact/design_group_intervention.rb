module Aact
  class DesignGroupIntervention < StudyRelationship
    belongs_to :intervention, inverse_of: :design_group_interventions
    belongs_to :design_group, inverse_of: :design_group_interventions
  end
end
