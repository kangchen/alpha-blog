# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# seed for development: rake db:seed
# seed for production: rake db:seed RAILS_ENV=production

25.times do
  Article.create({
    title: Faker::Book.title,
    description: Faker::Lorem.paragraphs(3, false),
    user_id: rand(25..31)
  })
end

# 7.times do
#   User.create({
#     username: Faker::Name.first_name,
#     email: Faker::Internet.email,
#     password: Faker::Internet.password(8),
#     admin: 0
#   })
# end
