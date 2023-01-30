class User < ApplicationRecord
  has_many :attendances, dependent: :destroy

  attr_accessor :remember_token # 「remember_token」という仮想の属性を作成します。
  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :affiliation, length: { in: 2..30 }, allow_blank: true
  validates :employee_number, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: true
  validates :basic_work_time, presence: true
  validates :designated_work_start_time, presence: true
  validates :designated_work_end_time, presence: true
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  def User.digest(string) # 渡された文字列のハッシュ値を返します。
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

 
  def User.new_token # ランダムなトークンを返します。
    SecureRandom.urlsafe_base64
  end

  
  def remember# 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)# トークンがダイジェストと一致すればtrueを返します。
    return false if remember_digest.nil? # ダイジェストが存在しない場合はfalseを返して終了します。
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget # ユーザーのログイン情報を破棄します。
    update_attribute(:remember_digest, nil)
  end

  def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
      user = find_by(id: row["id"]) || new # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      user.attributes = row.to_hash.slice(*updatable_attributes)  # CSVからデータを取得し、設定する
      user.save!(validate: false)
    end
  end
  
  def self.updatable_attributes # 更新を許可するカラムを定義
    ["name", "email", "affiliation", "employee_number", "uid",
      "basic_work_time", "designated_work_start_time", "designated_work_end_time",
      "superior", "admin", "password"]
  end
end