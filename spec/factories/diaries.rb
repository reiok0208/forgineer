FactoryBot.define do
  factory :diary do
    sequence(:title) { |n| "日記#{n}" }
    sequence(:body) { |n| "日記#{n}" }
  end
end
