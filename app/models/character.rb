class Character < ActiveRecord::Base
  has_many :character_languages, dependent: :destroy
  has_many :languages, through: :character_languages

  has_many :character_quizzes, dependent: :destroy
  has_many :quizzes, through: :character_quizzes

  validates :modern, presence: true

  def meaning_for(language)
    lang = Language.find_by(name: language.downcase)
    character_languages.find_by(language_id: lang.id).try(:meaning)
  end

  def to_s
    modern
  end

  class << self
    def full_search(query)
      if query.length == 1
        Character.where("modern = :query OR old = :query OR radical = :query OR grade = :query",
                        query: query)
      else
        language_matches = CharacterLanguage.where("meaning ILIKE :query OR pronunciation ILIKE :query",
                                                   query: "%#{query}%")
        Character.joins(:character_languages).where("character_languages.id in (?)", language_matches.map(&:id))
      end
    end

    def language_table(*languages)
      languages.flatten!
      if languages.all? { |l| l.is_a?(String) }
        languages = Language.where(name: languages)
      elsif !languages.all? { |l| l.is_a?(Language) }
        fail "Must provide languages as objects or names"
      end
      id_map = languages.map { |lang| [lang.id, lang.name] }
      select_languages = []
      id_map.each do |id|
        select_languages << "#{id[1]}.meaning AS #{id[1]}_meaning, #{id[1]}.pronunciation AS #{id[1]}_pronunciation"
      end
      select_clause = "SELECT c.*, #{select_languages.join(", ")}"
      from_clause = "FROM characters c"
      join_clauses = id_map.map { |id| "LEFT JOIN character_languages #{id[1]} ON #{id[1]}.character_id = c.id AND #{id[1]}.language_id = #{id[0]}"}
      find_by_sql([select_clause, from_clause, join_clauses.join(" ")].join(" "))
    end
  end
end
