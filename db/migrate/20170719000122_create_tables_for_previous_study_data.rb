class CreateTablesForPreviousStudyData < ActiveRecord::Migration
  def change

    create_table :clinical_categories do |t|
      t.string  'name'
      t.string  'downcase_name'
    end

    create_table :analyzed_mesh_terms do |t|
      t.string  'qualifier'
      t.string  'identifier'
      t.string  'term'
      t.string  'downcase_term'
    end

    create_table :analyzed_free_text_terms do |t|
      t.string  'identifier'
      t.string  'term'
      t.string  'downcase_term'
    end

    create_table :categorized_terms do |t|
      t.string  'identifier'
      t.string  'clinical_category'
      t.string  'term_type'
    end

    add_index :categorized_terms, :identifier
    add_index :categorized_terms, :clinical_category
    add_index :categorized_terms, :term_type
    add_index :analyzed_free_text_terms, :term
    add_index :analyzed_free_text_terms, :downcase_term
    add_index :analyzed_mesh_terms, :qualifier
    add_index :analyzed_mesh_terms, :term
    add_index :analyzed_mesh_terms, :downcase_term
  end
end
