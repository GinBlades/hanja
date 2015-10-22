class CharacterMigration < ActiveRecord::Base
  self.table_name = :characters
end
class ChangeCharacterSymbolNames < ActiveRecord::Migration
  def up
    add_column :characters, :modern, :string
    add_column :characters, :traditional, :string
    CharacterMigration.all.each do |character|
      character.modern = character.new
      character.traditional = character.old
      character.save
    end
    change_column :characters, :modern, :string, null: false
    remove_column :characters, :new
    remove_column :characters, :old
  end

  def down
    add_column :characters, :new, :string
    add_column :characters, :old, :string
    CharacterMigration.all.each do |character|
      character.new = character.modern
      character.old = character.traditional
      character.save
    end
    remove_column :characters, :modern
    remove_column :characters, :traditional
  end
end
