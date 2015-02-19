require 'faker'

#Create Users
5.times do
  user = User.new(
    name:      Faker::Name.name,
    email:     Faker::Internet.email,
    password:  Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!
end

user = User.new(
  name:     "Gary Thomas",
  email:    "person@example.com",
  password: "password"
  )
  user.skip_confirmation!
  user.save!

users = User.all

# Create Wikis
50.times do
  wiki = Wiki.create!(
    user:  users.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
    )
end

wikis = Wiki.all

  puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
