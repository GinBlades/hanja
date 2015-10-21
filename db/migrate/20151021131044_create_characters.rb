class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :new, null: false
      t.string :old
      t.string :radical
      t.integer :strokes
      t.string :grade

      t.timestamps null: false
    end
  end
end
