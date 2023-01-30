# coding: utf-8
  User.create!(name: "人事総務部長(管理者）",
              email: "sample@email.com",
              affiliation: "人事総務部",
              employee_number: 1,
              uid: 1,
              password: "password",
              password_confirmation: "password",
              admin: true,
              superior: false)

  puts "User-1.created!(Admin-User)"
  
  User.create!(name: "部長（上長A）",
              email: "sample-a@email.com",
              affiliation: "情報システム部",
              employee_number: 2,
              uid: 2,
              password: "password",
              password_confirmation: "password",
              admin: false,
              superior: true)

  User.create!(name: "課長（上長B）",
              email: "sample-b@email.com",
              affiliation: "情報システム部",
              employee_number: 3,
              uid: 3,
              password: "password",
              password_confirmation: "password",
              admin: false,
              superior: true)
  
  puts "User-2.created!(Superior-A)"
  puts "User-3.created!(Superior-B)"
  
  User.create!(name: "ドラえもん",
              email: "sample-1@email.com",
              affiliation: "情報システム部",
              employee_number: 4,
              uid: 4,
              password: "password",
              password_confirmation: "password",
              admin: false,
              superior: false)
 
  User.create!(name: "のび太",
              email: "sample-2@email.com",
              affiliation: "情報システム部",
              employee_number: 5,
              uid: 5,
              password: "password",
              password_confirmation: "password",
              admin: false,
              superior: false)
              
  User.create!(name: "しずかちゃん",
              email: "sample-3@email.com",
              affiliation: "情報システム部",
              employee_number: 6,
              uid: 6,
              password: "password",
              password_confirmation: "password",
              admin: false,
              superior: false)
              
  User.create!(name: "スネ夫",
              email: "sample-4@email.com",
              affiliation: "情報システム部",
              employee_number: 7,
              uid: 7,
              password: "password",
              password_confirmation: "password",
              admin: false,
              superior: false)
              
  User.create!(name: "ジャイアン",
              email: "sample-5@email.com",
              affiliation: "情報システム部",
              employee_number: 8,
              uid: 8,
              password: "password",
              password_confirmation: "password",
              admin: false,
              superior: false)
              
  User.create!(name: "のび太ママ",
              email: "sample-6@email.com",
              affiliation: "情報システム部",
              employee_number: 9,
              uid: 9,
              password: "password",
              password_confirmation: "password",
              admin: false,
              superior: false)

  User.create!(name: "のび太パパ",
              email: "sample-7@email.com",
              affiliation: "情報システム部",
              employee_number: 10,
              uid: 10,
              password: "password",
              password_confirmation: "password",
              admin: false,
              superior: false)
              
  User.create!(name: "ドラミちゃん",
              email: "sample-8@email.com",
              affiliation: "情報システム部",
              employee_number: 11,
              uid: 11,
              password: "password",
              password_confirmation: "password",
              admin: false,
              superior: false)

  User.create!(name: "セワシくん",
              email: "sample-9@email.com",
              affiliation: "情報システム部",
              employee_number: 12,
              uid: 12,
              password: "password",
              password_confirmation: "password",
              admin: false,
              superior: false)            
  
  9.times do |n|
  puts "User-#{n+4}.created!"
  end
 
  12.times do |n|
    name  = Faker::Name.name
    email = "sample-#{n+10}@email.com"
    affiliation = "情報システム部"
    employee_number = n+13
    uid = n+13
    password = "password"
    admin = false
    superior = false

    User.create!(name: name,
                email: email,
                affiliation: affiliation,
                employee_number: employee_number,
                uid: uid,
                password: password,
                password_confirmation: password,
                admin: admin,
                superior: superior)
  
    puts "User-#{n+13}.created! (\"#{Faker::Name.name}\")" #Fakerの中身はUser-#{n+13}と一致しないで良い。やり方のみ記載。
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
              
  Base.create!(base_number: 35,
              base_name: "南極支社",
              work_type: "リモート")

  35.times do |n|

  puts "Base-#{n+1}.created!"
  end