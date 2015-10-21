class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :name
      t.belongs_to :from_language, index: true
      t.belongs_to :to_language, index: true

      t.timestamps null: false
    end

    add_foreign_key :quizzes, :languages, column: :from_language_id
    add_foreign_key :quizzes, :languages, column: :to_language_id
  end
end
