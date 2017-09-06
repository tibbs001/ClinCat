class ClinicalCategory < ActiveRecord::Base

  def self.indexed_categories
   { 2=>'CARDIOLOGY',
     3=>'DERMATOLOGY',
     4=>'ENDOCRINOLOGY',
     5=>'GI_HEPATOLOGY',
     6=>'IMMUNO_RHEUMATOLOGY',
     7=>'INFECTIOUS_DISEASES',
     8=>'NEPHROLOGY',
     9=>'NEUROLOGY',
     10=>'PSYCH_GENERAL',
     11=>'ONCOLOGY',
     12=>'OTOLARYNGOLOGY',
     13=>'PULMONARY_MEDICINE',
     14=>'REPRODUCTIVE_MEDICINE',
     15=>'PSYCH_SPECIFIC',
     16=>'HEPATOLOGY_SPECIFIC'
   }
  end

end

