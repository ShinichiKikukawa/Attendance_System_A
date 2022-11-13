# coding: utf-8

User.create!(name: "管理者",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)

puts "Admin User.created!"

10.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)

puts "User-#{n+1}.created!"
end

  Base.create!(base_number: 1,
               base_name: "自宅",
               work_type: "リモート")
               
  Base.create!(base_number: 2,
               base_name: "渋谷本社",
               work_type: "出社")
  
  Base.create!(base_number: 3,
               base_name: "シリコンバレー支社",
               work_type: "リモート")
               
  Base.create!(base_number: 4,
               base_name: "カナダ支社",
               work_type: "リモート")
               
  Base.create!(base_number: 5,
               base_name: "オランダ支社",
               work_type: "リモート")
               
  Base.create!(base_number: 6,
               base_name: "デンマーク支社",
               work_type: "リモート")
  
  Base.create!(base_number: 7,
               base_name: "シンガポール支社",
               work_type: "リモート")
               
  Base.create!(base_number: 8,
               base_name: "ベトナム支社",
               work_type: "リモート")

  Base.create!(base_number: 9,
               base_name: "マレーシア支社",
               work_type: "リモート")
               
  Base.create!(base_number: 10,
               base_name: "インド支社",
               work_type: "リモート")
               
               

puts "Base-1.created!"
puts "Base-2.created!"
puts "Base-3.created!"
puts "Base-4.created!"
puts "Base-5.created!"
puts "Base-6.created!"
puts "Base-7.created!"
puts "Base-8.created!"
puts "Base-9.created!"
puts "Base-10.created!"
