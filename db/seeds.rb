# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = 'password123'

10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: PASSWORD
  )
end

users = User.all

100.times do
  Question.create(
    title: Faker::Book.title,
    body: Faker::Hipster.paragraph,
    user: users.sample
  )
end

10.times do
  Tag.create name: Faker::Hipster.word
end
