class CharacterQuiz < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :character

  validates :quiz_id, :character_id, presence: true
end
