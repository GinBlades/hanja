class RequiredFieldsForQuizzes < ActiveRecord::Migration
  def up
    change_column :quizzes, :user_id, :integer, null: false
    change_column :quizzes, :name, :string, null: false
    change_column :quizzes, :from_language_id, :integer, null: false
    change_column :quizzes, :to_language_id, :integer, null: false

    change_column :character_quizzes, :character_id, :integer, null: false
    change_column :character_quizzes, :quiz_id, :integer, null: false

    add_index :character_quizzes, [:quiz_id, :character_id], unique: true
  end

  def down
    change_column :quizzes, :user_id, :integer, null: true
    change_column :quizzes, :name, :string, null: true
    change_column :quizzes, :from_language_id, :integer, null: true
    change_column :quizzes, :to_language_id, :integer, null: true

    change_column :character_quizzes, :character_id, :integer, null: true
    change_column :character_quizzes, :quiz_id, :integer, null: true

    remove_index :character_quizzes, [:quiz_id, :character_id]
  end
end
