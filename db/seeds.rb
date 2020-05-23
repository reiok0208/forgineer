# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([
  {name: "岡田黎",nickname: "おかぴー",email: "test1@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "山田太郎",nickname: "たろう",email: "test2@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "山田花子",nickname: "はな",email: "test3@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test4@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test5@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test6@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test7@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test8@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test9@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test10@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test11@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test12@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test13@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test14@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test15@mail.com",password: "test1111",password_confirmation: "test1111"},
  {name: "無名",nickname: "むめい",email: "test16@mail.com",password: "test1111",password_confirmation: "test1111"}
])

20.times do
  Diary.create!(
    user_id: 1,
    title: "タイトル",
    body: "内容です"
  )
end

Tag.create!([
  {name: "rubyonrails",description: "タイトル"},
  {name: "ruby",description: "タイトル"},
  {name: "html",description: "タイトル"},
  {name: "css",description: "タイトル"},
  {name: "java",description: "タイトル"},
  {name: "javascript",description: "タイトル"},
  {name: "swift",description: "タイトル"},
  {name: "php",description: "タイトル"},
  {name: "aql",description: "タイトル"}
])

Relationship.create!([
  {follower_id: 2,followed_id: 1},
  {follower_id: 2,followed_id: 16},
  {follower_id: 2,followed_id: 3},
  {follower_id: 2,followed_id: 4},
  {follower_id: 2,followed_id: 5},
  {follower_id: 2,followed_id: 6},
  {follower_id: 2,followed_id: 7},
  {follower_id: 2,followed_id: 8},
  {follower_id: 2,followed_id: 9},
  {follower_id: 2,followed_id: 10},
  {follower_id: 2,followed_id: 11},
  {follower_id: 2,followed_id: 12},
  {follower_id: 2,followed_id: 13},
  {follower_id: 2,followed_id: 14},
  {follower_id: 2,followed_id: 15},
  {follower_id: 1,followed_id: 2},
  {follower_id: 3,followed_id: 2},
  {follower_id: 4,followed_id: 2},
  {follower_id: 5,followed_id: 2},
  {follower_id: 6,followed_id: 2},
  {follower_id: 7,followed_id: 2},
  {follower_id: 8,followed_id: 2},
  {follower_id: 9,followed_id: 2},
  {follower_id: 10,followed_id: 2},
  {follower_id: 11,followed_id: 2},
  {follower_id: 12,followed_id: 2},
  {follower_id: 13,followed_id: 2},
  {follower_id: 14,followed_id: 2},
  {follower_id: 15,followed_id: 2},
  {follower_id: 16,followed_id: 2}
])