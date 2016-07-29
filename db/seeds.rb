# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

6.times do |n|
  name  = "hannah_#{n+1}"
  email = "noreply_#{n+1}@comlink.com"
  password = "can23409_fjk23449"
  User.create!(user_name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
6.times do
  link = "https://www.sitepoint.com/infinite-scrolling-rails-basics/"
  commentary = Faker::Lorem.sentence(5)
  tag_list = "hello there"
  users.each {
    |user| user.posts.create!(link: link,
                            tag_list: tag_list,
                            commentary: commentary)
  }
end

