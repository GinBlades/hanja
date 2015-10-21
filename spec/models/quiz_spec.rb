require "rails_helper"

RSpec.describe Quiz, type: :model do
  it "has a valid factory" do
    expect(build(:quiz)).to be_valid
  end
end
