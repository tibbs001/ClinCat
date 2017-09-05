class AnalyzedFreeTextTerm < ActiveRecord::Base
  def self.populate_from_file(file_name=Rails.root.join('csv','analyzed_free_text_terms.csv'))
    puts "about to populate table of old free text terms..."
    File.open(file_name).each_line{|line|
      line_array=line.split('|')
      old_id=line_array[0]
      term=line_array[1].strip
      if !old_id.nil? and old_id != 'FREE_TEXT_CONDITION_ID'
        new(:old_id=>old_id,
            :free_text_term=>term,
            :downcase_free_text_term=>term.downcase,
        ).save
        (2..15).each{|i|
          if line_array[i]=='Y'
            CategorizedTerm.create(
              :old_id=>old_id,
              :clinical_category=>indexed_categories[i],
              :term_type=>'free'
            ).save!
          end
        }
      end
    }
  end

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

  def self.ids_related_to(incoming_terms=[])
    ids=[]
    incoming_terms.each {|term|
      searchable_term="%#{term.downcase}%"
      terms=MeshTerm.where('downcase_mesh_term like ?',searchable_term).pluck("mesh_term").uniq
      terms.each{|term|
        t=term.downcase
        ids << BrowseCondition.where('downcase_mesh_term = ?',t).pluck(:nct_id).uniq
        ids << BrowseIntervention.where('downcase_mesh_term = ?',t).pluck(:nct_id).uniq
      }
    }
    ids.flatten.uniq
  end

end
