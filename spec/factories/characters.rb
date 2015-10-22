FactoryGirl.define do
  factory :character do
    sequence(:modern) { |n| n.to_s }
    sequence(:traditional) { |n| n.to_s }
    sequence(:radical) { |n| n.to_s }
    strokes { |n| rand(30) }
    grade { %w(1 2 3 4 S).sample }
  end

end
