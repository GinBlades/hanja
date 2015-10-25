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

    def language_table(from, to)
      f_id = from.is_a?(Language) ? from.id : Language.find_by(name: from).id
      t_id = to.is_a?(Language) ? to.id : Language.find_by(name: to).id
      select = "SELECT c.*, f.meaning AS from_meaning, f.pronunciation AS from_pronunciation, t.meaning AS to_meaning, t.pronunciation AS to_pronunciation"
      from_join = "FROM characters c LEFT JOIN character_languages f ON f.character_id = c.id AND f.language_id = #{f_id}"
      to_join = "left join character_languages t on t.character_id = c.id and t.language_id = #{t_id}"
      find_by_sql([select, from_join, to_join].join(" "))
    end

    def language_table_all(languages)
      fail "Please only search for less than 20 languages." if languages.length > 20
      if languages.all? { |l| l.is_a?(Language) }
        ids = languages.map(&:id)
      elsif languages.all? { |l| l.is_a?(String) }
        ids = Language.where(name: languages).map(&:id)
      else
        fail "Must provide languages as objects or names"
      end
      id_map = ids.zip("a".."z")
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
