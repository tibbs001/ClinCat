module Aact
  class Sponsor < StudyRelationship
    scope :named, lambda {|agency| where("name LIKE ?", "#{agency}%" )}
  end
end
