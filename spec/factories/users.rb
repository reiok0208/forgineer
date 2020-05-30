FactoryBot.define do
  factory :user do
    name { "テスト太郎" }
    nickname { "テスト" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "testTarou1111" }
  end
end
