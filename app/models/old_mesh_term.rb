class OldMeshTerm < ActiveRecord::Base
  def self.populate_from_file(file_name=Rails.root.join('public','old_mesh_terms.csv'))
    puts "about to populate table of old mesh terms..."
    File.open(file_name).each_line{|line|
      line_array=line.split('|')
      tree=line_array.first
      qualifier=tree.split('.').first
      desc=''
      term=line_array[1].strip
      if !qualifier.nil? and qualifier != 'MESH_ID'
        new(:qualifier=>qualifier,
            :tree_number=>tree,
            :description=>desc,
            :downcase_mesh_term=>term.downcase,
            :mesh_term=>term,
        ).save
        (3..16).each{|i|
          if line_array[i]=='Y'
            OldCategorizedTerm.create(:tree_number=>tree,
                                   :clinical_category=>indexed_categories[i]
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
