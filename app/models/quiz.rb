class Quiz < ActiveRecord::Base
  belongs_to :user
  belongs_to :from_language, class_name: "Language"
  belongs_to :to_language, class_name: "Language"

  has_many :character_quizzes, dependent: :destroy
  has_many :characters, through: :character_quizzes

  before_validation :default_name
  validates :user_id, :from_language_id, :to_language_id, :name, presence: true

  protected

    def default_name
      self.name = "#{from_language.name} - #{to_language.name}" if name.empty?
    end
end
