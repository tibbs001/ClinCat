class CreateTablesFrom2011 < ActiveRecord::Migration
  def change

    create_table :old_mesh_terms do |t|
      t.string  'qualifier'
      t.string  'tree_number'
      t.string  'description'
      t.string  'mesh_term'
      t.string  'downcase_mesh_term'
    end

    create_table :old_free_text_terms do |t|
      t.integer 'old_id'
      t.string  'free_text_term'
      t.string  'downcase_free_text_term'
    end

    create_table :categories do |t|
      t.string  'name'
    end

    create_table :old_categorized_terms do |t|
      t.integer 'old_id'
      t.string  'tree_number'
      t.string  'clinical_category'
      t.string  'term_type'
    end

    add_index :old_categorized_terms, :tree_number
    add_index :old_categorized_terms, :clinical_category
    add_index :old_categorized_terms, :term_type
    add_index :old_free_text_terms, :free_text_term
    add_index :old_free_text_terms, :downcase_free_text_term
    add_index :old_mesh_terms, :qualifier
    add_index :old_mesh_terms, :description
    add_index :old_mesh_terms, :mesh_term
    add_index :old_mesh_terms, :downcase_mesh_term
  end
end
