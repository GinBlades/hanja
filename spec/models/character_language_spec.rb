require "rails_helper"

RSpec.describe CharacterLanguage, type: :model do
  it "has a valid factory" do
    expect(build(:character_language)).to be_valid
  end
end
