# coding: utf-8

User.create!(name: "管理者",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)

puts "Admin User.created!"

50.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

puts "User-#{n+1}.created!"

15.times do |b|
  base_number  = "#{b+1}"
  base_name = Faker::Nation.capital_city
  work_type = "リモート"
  Base.create!(base_number: base_number,
               base_name: base_name,
               work_type: work_type)
end

puts "Base-#{n+1}.created!"
