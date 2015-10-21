require "rails_helper"

RSpec.describe Character, type: :model do
  it "has a valid factory" do
    expect(build(:character)).to be_valid
  end
end
