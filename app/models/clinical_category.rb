class ClinicalCategory < ActiveRecord::Base

  def self.get_category_for(year, index, term_type)
    return mesh_cat_2010[index] if year == '2010' && term_type == 'mesh'
    return mesh_cat_2017[index] if year == '2017' && term_type == 'mesh'
  end

  def self.mesh_cat_2010
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

  def self.mesh_cat_2017
    {
      2=>'PULMONARY',
      3=>'TRANSPLANT',
    }
  end

  def self.indexed_free_text_categories
   { 2=>  'CARDIOLOGY',
     3=>  'DERMATOLOGY',
     4=>  'ENDOCRINOLOGY',
     5=>  'GI_HEPATOLOGY',
     6=>  'IMMUNO_RHEUMATOLOGY',
     7=>  'INFECTIOUS_DISEASES',
     8=>  'NEPHROLOGY',
     9=>  'NEUROLOGY',
     10=> 'PSYCH_GENERAL',
     11=> 'PSYCH_SPECIFIC',
     12=> 'ONCOLOGY_GENERAL',
     13=> 'ONCOLOGY_SPECIFIC',
     14=> 'OTOLARYNGOLOGY',
     15=> 'PULMONARY_MEDICINE',
     16=> 'REPRODUCTIVE_MEDICINE',
     17=> 'PAD',
     18=> 'PVD',
     19=> 'BONE_GENERAL',
     20=> 'BONE_SPECIFIC',
     21=> 'DIABETES_GENERAL',
     22=> 'DIABETES_SPECIFIC',
     23=> 'THYROID_GENERAL',
     24=> 'HEPATOLOGY_SPECIFIC',
   }
  end

end

