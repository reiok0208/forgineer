FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "機能#{n}" }
  end
end
