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
  password: "password",
  role:     "premium"
  )
  user.skip_confirmation!
  user.save!

user = User.new(
  name:     "Mike Thorp",
  email:    "example@example.com",
  password: "password"
  )
  user.skip_confirmation!
  user.save!

user = User.new(
  name:      "Admin",
  email:     "admin@example.com",
  password:  "testing1",
  role:      "admin"
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
