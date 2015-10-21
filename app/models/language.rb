class Language < ActiveRecord::Base
  has_many :character_languages, dependent: :destroy
  has_many :characters, through: :character_languages

  validates :name, presence: true

  def to_s
    name
  end
end
