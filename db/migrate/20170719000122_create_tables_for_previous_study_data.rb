class CreateTablesForPreviousStudyData < ActiveRecord::Migration
  def change

    create_table :analyzed_mesh_terms do |t|
      t.string  'qualifier'
      t.string  'identifier'
      t.string  'term'
      t.string  'former_term'
      t.string  'downcase_term'
      t.string  'year'
      t.string  'note'
    end

    create_table :analyzed_free_text_terms do |t|
      t.string  'identifier'
      t.string  'term'
      t.string  'downcase_term'
      t.string  'year'
      t.string  'note'
    end

    create_table :categorized_terms do |t|
      t.string  'identifier'
      t.string  'term_type'
      t.string  'category'
      t.string  'year'
    end

    add_index :categorized_terms, :identifier
    add_index :categorized_terms, :category
    add_index :categorized_terms, :term_type
    add_index :analyzed_free_text_terms, :term
    add_index :analyzed_free_text_terms, :downcase_term
    add_index :analyzed_free_text_terms, :year
    add_index :analyzed_free_text_terms, :note
    add_index :analyzed_mesh_terms, :qualifier
    add_index :analyzed_mesh_terms, :term
    add_index :analyzed_mesh_terms, :downcase_term
    add_index :analyzed_mesh_terms, :year
    add_index :analyzed_mesh_terms, :note
  end
end
