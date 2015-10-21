class Character < ActiveRecord::Base
  has_many :character_languages, dependent: :destroy
  has_many :languages, through: :character_languages

  def meaning_for(language)
    lang = Language.find_by(name: language.downcase)
    character_languages.find_by(language_id: lang.id).try(:meaning)
  end
end
