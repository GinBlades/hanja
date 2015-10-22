FactoryGirl.define do
  factory :character do
    sequence(:modern) { |n| "#{n}" }
    traditional { modern }
    radical { modern }
    strokes { rand(30) }
    grade { %w(1 2 3 4 S).sample }
  end
end
