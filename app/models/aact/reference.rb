module Aact
  class Reference < StudyRelationship
    self.table_name='study_references'

    def type
      reference_type
    end

  end
end
