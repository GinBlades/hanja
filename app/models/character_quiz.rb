class CharacterQuiz < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :character
end
