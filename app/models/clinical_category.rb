class ClinicalCategory < ActiveRecord::Base

  def self.get_category_for(year, index, term_type)
    if term_type == 'mesh'
      return mesh_2010[index] if year == '2010'
      return mesh_2017[index] if year == '2017'
    else
      return free_2010[index] if year == '2010'
      return free_2017[index] if year == '2017'
    end

  end

  def self.mesh_2010
    {
      2=>'CARDIOLOGY',
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

  def self.mesh_2017
    {
      2=>'PULMONARY',
      3=>'TRANSPLANT',
    }
  end

  def self.free_2010
   { 1=>  'CARDIOLOGY',
     2=>  'DERMATOLOGY',
     3=>  'ENDOCRINOLOGY',
     4=>  'GI_HEPATOLOGY',
     5=>  'IMMUNO_RHEUMATOLOGY',
     6=>  'INFECTIOUS_DISEASES',
     7=>  'NEPHROLOGY',
     8=>  'NEUROLOGY',
     9=> 'PSYCH_GENERAL',
     10=> 'PSYCH_SPECIFIC',
     11=> 'ONCOLOGY_GENERAL',
     12=> 'ONCOLOGY_SPECIFIC',
     13=> 'OTOLARYNGOLOGY',
     14=> 'PULMONARY_MEDICINE',
     15=> 'REPRODUCTIVE_MEDICINE',
     16=> 'PAD',
     17=> 'PVD',
     18=> 'BONE_GENERAL',
     29=> 'BONE_SPECIFIC',
     30=> 'DIABETES_GENERAL',
     31=> 'DIABETES_SPECIFIC',
     32=> 'THYROID_GENERAL',
     33=> 'HEPATOLOGY_SPECIFIC',
   }
  end

  def self.free_2017
    {
      1=>'PULMONARY',
      2=>'TRANSPLANT',
    }
  end

end

