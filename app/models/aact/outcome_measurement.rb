module Aact
  class OutcomeMeasurement < Aact
    belongs_to :outcome
    belongs_to :result_group
  end
end
