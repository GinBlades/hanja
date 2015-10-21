require "rails_helper"

RSpec.describe CharacterQuiz, type: :model do
  it "has a valid factory" do
    expect(build(:character_quiz)).to be_valid
  end
end
