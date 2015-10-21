class CharacterLanguage < ActiveRecord::Base
  belongs_to :language
  belongs_to :character

  validates :language_id, :character_id, presence: true
end
