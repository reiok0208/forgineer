# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([
  {name: "岡田黎",nickname: "おかぴー",email: "test1@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "山田太郎",nickname: "たろう",email: "test2@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "山田花子",nickname: "はな",email: "test3@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test4@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test5@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test6@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test7@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test8@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test9@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test10@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test11@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test12@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test13@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test14@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test15@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"},
  {name: "無名",nickname: "むめい",email: "test16@mail.com",password: "test1111",password_confirmation: "test1111",profile_image_id: "1"}
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