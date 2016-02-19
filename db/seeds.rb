# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Start seed"


puts "Seeding users"
50.times do
  User.create! name: Faker::Name.name,
               email: Faker::Internet.email,
               password: 'password'
end


puts "Seeding tags"
20.times do
  Tag.create! name: Faker::Lorem.word
end

puts "Seeding articles"
200.times do
  Article.create! title: Faker::Lorem.sentence,
                 text: Faker::Lorem.paragraphs(rand(5..10)).join("\n\n"),
                 author: Faker::Name.name,
                 created_at: Faker::Date.between(60.days.ago, Date.today)
end

Article.all.each do |article|
  rand(5..20).times do
    article.comments.create! commenter: Faker::Name.name,
                            body: Faker::Lorem.sentences(rand(1..5)).join('\s')
  end
  rand(1..5).times do
    article.tags << Tag.all.sample
  end
end
puts "End seed"
