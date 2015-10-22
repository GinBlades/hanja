class Quiz < ActiveRecord::Base
  belongs_to :user
  belongs_to :from_language, class_name: "Language"
  belongs_to :to_language, class_name: "Language"

  has_many :character_quizzes, dependent: :destroy
  has_many :characters, through: :character_quizzes

  validates :user_id, :from_language_id, :to_language_id, :name, presence: true
end
