# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

6.times do |n|
  name  = Faker::Name.name.first(13)
  email = "noreply_#{n+1}@comlink.com"
  password = "password"
  User.create!(user_name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
6.times do
  title = Faker::Lorem.sentence(1)
  link = "https://www.sitepoint.com/infinite-scrolling-rails-basics/"
  commentary = Faker::Lorem.sentence(5)
  users.each {
    |user| user.posts.create!(link: link,
                            title: title,
                            commentary: commentary)
  }
end

