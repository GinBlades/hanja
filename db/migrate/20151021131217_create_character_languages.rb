class CreateCharacterLanguages < ActiveRecord::Migration
  def change
    create_table :character_languages do |t|
      t.belongs_to :language, index: true, foreign_key: true, null: false
      t.belongs_to :character, index: true, foreign_key: true, null: false
      t.string :meaning
      t.string :pronunciation

      t.timestamps null: false
    end

    add_index :character_languages, [:language_id, :character_id], unique: true
  end
end
