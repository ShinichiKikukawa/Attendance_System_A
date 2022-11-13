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
               base_name: "ニューヨーク支社",
               work_type: "リモート")
               
  Base.create!(base_number: 5,
               base_name: "ワシントンD.C.支社",
               work_type: "リモート")
               
  Base.create!(base_number: 6,
               base_name: "フロリダ支社",
               work_type: "リモート")
  
  Base.create!(base_number: 7,
               base_name: "ハワイ支社",
               work_type: "リモート")
               
  Base.create!(base_number: 8,
               base_name: "カナダ支社",
               work_type: "リモート")

  Base.create!(base_number: 9,
               base_name: "ロンドン支社",
               work_type: "リモート")
               
  Base.create!(base_number: 10,
               base_name: "パリ支社",
               work_type: "リモート")
               
  Base.create!(base_number: 11,
               base_name: "ベルリン支社",
               work_type: "リモート")
               
  Base.create!(base_number: 13,
               base_name: "ローマ支社",
               work_type: "リモート")
               
  Base.create!(base_number: 14,
               base_name: "オランダ支社",
               work_type: "リモート")
               
  Base.create!(base_number: 15,
               base_name: "デンマーク支社",
               work_type: "リモート")
               
  Base.create!(base_number: 16,
               base_name: "スイス支社",
               work_type: "リモート")
               
  Base.create!(base_number: 17,
               base_name: "ルクセンブルク支社",
               work_type: "リモート")
               
  Base.create!(base_number: 18,
               base_name: "マドリード支社",
               work_type: "リモート")
               
  Base.create!(base_number: 19,
               base_name: "深圳支社",
               work_type: "リモート")
               
  Base.create!(base_number: 20,
               base_name: "シンガポール支社",
               work_type: "リモート")
               
  Base.create!(base_number: 21,
               base_name: "ベトナム支社",
               work_type: "リモート")
               
  Base.create!(base_number: 22,
               base_name: "マレーシア支社",
               work_type: "リモート")
               
  Base.create!(base_number: 23,
               base_name: "バンコク支社",
               work_type: "リモート")
               
  Base.create!(base_number: 24,
               base_name: "ソウル支社",
               work_type: "リモート")
               
  Base.create!(base_number: 25,
               base_name: "インド支社",
               work_type: "リモート")
               
  Base.create!(base_number: 26,
               base_name: "ナイジェリア支社",
               work_type: "リモート")
               
  Base.create!(base_number: 27,
               base_name: "エジプト支社",
               work_type: "リモート")
               
  Base.create!(base_number: 28,
               base_name: "南アフリカ支社",
               work_type: "リモート")
               
  Base.create!(base_number: 29,
               base_name: "トルコ支社",
               work_type: "リモート")
               
  Base.create!(base_number: 30,
               base_name: "ブラジル支社",
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
puts "Base-11.created!"
puts "Base-12.created!"
puts "Base-13.created!"
puts "Base-14.created!"
puts "Base-15.created!"
puts "Base-16.created!"
puts "Base-17.created!"
puts "Base-18.created!"
puts "Base-19.created!"
puts "Base-20.created!"
puts "Base-21.created!"
puts "Base-22.created!"
puts "Base-23.created!"
puts "Base-24.created!"
puts "Base-25.created!"
puts "Base-26.created!"
puts "Base-27.created!"
puts "Base-28.created!"
puts "Base-29.created!"
puts "Base-30.created!"

