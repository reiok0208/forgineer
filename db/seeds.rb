# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: "岡田黎",
  nickname: "おかぴー",
  email: "test1@mail.com",
  password: "test1111",
  password_confirmation: "test1111",
  profile_imege_id: "1"
)

20.times do
  Diary.create!(
    user_id: 1,
    title: "タイトル",
    body: "内容です"
  )
end

10.times do
  Tag.create!(
    name: "Ruby on Rails",
    description: "タイトル"
  )
end

10.times do
  DiaryTag.create!(
    diary_id: 20,
    tag_id: 1
  )
end