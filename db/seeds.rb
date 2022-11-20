# coding: utf-8

User.create!(name: "管理者",
             email: "sample@email.com",
             employee_number: 1,
             password: "password",
             password_confirmation: "password",
             admin: true)

puts "Admin User.created!"

 User.create!(name: "ドラえもん",
              email: "d@email.com",
              employee_number: 2,
              password: "password",
              password_confirmation: "password")
              
 User.create!(name: "のび太",
              email: "n@email.com",
              employee_number: 3,
              password: "password",
              password_confirmation: "password")
              
 User.create!(name: "しずかちゃん",
              email: "s@email.com",
              employee_number: 4,
              password: "password",
              password_confirmation: "password")
              
  User.create!(name: "スネ夫",
              email: "suneo@email.com",
              employee_number: 5,
              password: "password",
              password_confirmation: "password")
              
   User.create!(name: "ジャイアン",
              email: "j@email.com",
              employee_number: 6,
              password: "password",
              password_confirmation: "password")
              
  User.create!(name: "のび太ママ",
              email: "m@email.com",
              employee_number: 7,
              password: "password",
              password_confirmation: "password")

  User.create!(name: "のび太パパﾟ",
              email: "p@email.com",
              employee_number: 8,
              password: "password",
              password_confirmation: "password")
              
  User.create!(name: "ドラミ",
              email: "dorami@email.com",
              employee_number: 9,
              password: "password",
              password_confirmation: "password")
              
  User.create!(name: "パピくん",
              email: "papikun@email.com",
              employee_number: 10,
              password: "password",
              password_confirmation: "password")

10.times do |n|
puts "User#{n+1}.created!"
end
              
10.times do |n|
  name  = Faker::Name.name
  email = "sample#{n+11}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               employee_number: n+11,
               password: password,
               password_confirmation: password)

puts "User#{n+11}.created!"
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
               base_name: "インドネシア支社",
               work_type: "リモート")
               
  Base.create!(base_number: 25,
               base_name: "ソウル支社",
               work_type: "リモート")
               
  Base.create!(base_number: 26,
               base_name: "インド支社",
               work_type: "リモート")
               
  Base.create!(base_number: 27,
               base_name: "ナイジェリア支社",
               work_type: "リモート")
               
  Base.create!(base_number: 28,
               base_name: "エジプト支社",
               work_type: "リモート")
               
  Base.create!(base_number: 29,
               base_name: "南アフリカ支社",
               work_type: "リモート")
               
  Base.create!(base_number: 30,
               base_name: "トルコ支社",
               work_type: "リモート")
               
  Base.create!(base_number: 31,
               base_name: "ドバイ支社",
               work_type: "リモート")
               
  Base.create!(base_number: 32,
               base_name: "サウジアラビア支社",
               work_type: "リモート")
  
  Base.create!(base_number: 33,
               base_name: "イスラエル支社",
               work_type: "リモート")
  
  Base.create!(base_number: 34,
               base_name: "ブラジル支社",
               work_type: "リモート")
               
               
               
34.times do |n|

puts "Base#{n+1}.created!"               
end