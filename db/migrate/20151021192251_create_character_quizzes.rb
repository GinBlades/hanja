class CreateCharacterQuizzes < ActiveRecord::Migration
  def change
    create_table :character_quizzes do |t|
      t.belongs_to :quiz, index: true, foreign_key: true
      t.belongs_to :character, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
