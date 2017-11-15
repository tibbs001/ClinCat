require 'active_support/all'
class CategorizedTerm < ActiveRecord::Base

  belongs_to :analyzed_mesh_term, :foreign_key => 'identifier'
  #belongs_to :analyzed_free_text_term, :foreign_key => 'identifier'

  def self.ignore_key
    ['compare','mesh_id','mesh_term','name','term','num_studies','note','qualifier_term','qualifier']
  end

  def self.create_for(row, year, term_type)
    row.each { |key, value|
      # id column could either be called mesh_id or identifier
      id=row['mesh_id']
      id=row['identifier'] if id.nil?
      if !(ignore_key.include? key.downcase) && value.try(:downcase) == 'y'
        new(
          :identifier=>id,
          :category=>key.split.map(&:capitalize).join(' ').strip,
          :term_type=>term_type,
          :year=>year
        ).save!
      end
    }
  end

end
