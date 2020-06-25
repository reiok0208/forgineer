FactoryBot.define do
  factory :comment do
    sequence(:title) { |n| "コメント#{n}" }
    sequence(:body) { |n| "コメント#{n}" }
  end
end
