class Character < ActiveRecord::Base
  has_many :character_languages, dependent: :destroy
  has_many :languages, through: :character_languages

  has_many :character_quizzes, dependent: :destroy
  has_many :quizzes, through: :character_quizzes

  def meaning_for(language)
    lang = Language.find_by(name: language.downcase)
    character_languages.find_by(language_id: lang.id).try(:meaning)
  end

  def to_s
    new
  end

  class << self
    def full_search(query)
      if query.length == 1
        Character.where("new = :query OR old = :query OR radical = :query OR grade = :query", {query: query}) if query.length < 3
      else
        language_matches = CharacterLanguage.where("meaning ILIKE :query OR pronunciation ILIKE :query", {query: "%#{query}%"}) if query.length >= 3
        Character.joins(:character_languages).where("character_languages.id in (?)", language_matches.map(&:id))
      end
    end
  end
end
