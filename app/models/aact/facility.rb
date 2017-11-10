module Aact
  class Facility < StudyRelationship

    has_many :facility_contacts
    has_many :facility_investigators

  end
end
