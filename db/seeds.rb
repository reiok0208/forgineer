# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([
  #user_id1は管理者、user_id2は非ログインのユーザーのコメントに使用
  {name: "管理者",nickname: "管理者",email: "admin@mail.com",password: "admin1111",password_confirmation: "admin1111",admin: true},
  {name: "非会員",nickname: "非会員",email: "test1@mail.com",password: "test1111",password_confirmation: "test1111",admin: false},
  {name: "テスト会員",nickname: "テスト",email: "test1@mail.com",password: "test1111",password_confirmation: "test1111",admin: false},
  {name: "町田悠里",nickname: "まっちー",email: "test2@mail.com",password: "test1111",password_confirmation: "test1111",admin: false},
  {name: "西川真人",nickname: "にっしー",email: "test3@mail.com",password: "test1111",password_confirmation: "test1111",admin: false},
  {name: "関根宏侑",nickname: "せっきー",email: "test4@mail.com",password: "test1111",password_confirmation: "test1111",admin: false},
  {name: "原荘介",nickname: "はらっち",email: "test5@mail.com",password: "test1111",password_confirmation: "test1111",admin: false},
  {name: "原口長生",nickname: "ぐっちー",email: "test6@mail.com",password: "test1111",password_confirmation: "test1111",admin: false},
  {name: "橋本良秋",nickname: "はっしー",email: "test7@mail.com",password: "test1111",password_confirmation: "test1111",admin: false},
  {name: "平川征輝",nickname: "ひら",email: "test8@mail.com",password: "test1111",password_confirmation: "test1111",admin: false},
  {name: "吉岡好利",nickname: "よっしー",email: "test9@mail.com",password: "test1111",password_confirmation: "test1111",admin: false},
  {name: "新谷酉蔵",nickname: "あらやん",email: "test10@mail.com",password: "test1111",password_confirmation: "test1111",admin: false}
])

Tag.create!([
  {name: "rubyonrails"},
  {name: "ruby"},
  {name: "html"},
  {name: "css"},
  {name: "java"},
  {name: "javascript"},
  {name: "swift"},
  {name: "php"},
  {name: "sql"}
])

Relationship.create!([
  {follower_id: 3,followed_id: 4},
  {follower_id: 3,followed_id: 5},
  {follower_id: 3,followed_id: 6},
  {follower_id: 3,followed_id: 7},
  {follower_id: 3,followed_id: 8},
  {follower_id: 3,followed_id: 9},
  {follower_id: 3,followed_id: 10},
  {follower_id: 3,followed_id: 11},
  {follower_id: 3,followed_id: 12},
  {follower_id: 4,followed_id: 3},
  {follower_id: 5,followed_id: 3},
  {follower_id: 6,followed_id: 3},
  {follower_id: 7,followed_id: 3},
  {follower_id: 8,followed_id: 3},
  {follower_id: 9,followed_id: 3},
  {follower_id: 10,followed_id: 3},
  {follower_id: 11,followed_id: 3},
  {follower_id: 12,followed_id: 3},
])