class Character < ActiveRecord::Base
  has_many :character_languages, dependent: :destroy
  has_many :languages, through: :character_languages

  mount_uploader :image, CharacterUploader
  validates :image, presence: true
end
