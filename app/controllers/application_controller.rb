class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  $days_of_the_week = %w{日 月 火 水 木 金 土}
  
  def set_user
    @user = User.find(params[:id])# paramsハッシュからユーザーを取得します。
  end

  
  def logged_in_user
    unless logged_in?# ログイン済みのユーザーか確認します。
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end

  
  def correct_user
    redirect_to(root_url) unless current_user?(@user)# アクセスしたユーザーが現在ログインしているユーザーか確認します。
  end

  
  def admin_user
    redirect_to root_url unless current_user.admin?# システム管理権限所有かどうか判定します。
  end
  
  def admin_or_correct_user
    @user = User.find(params[:user_id]) if @user.blank?
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "権限がありません"
      redirect_to current_user
    end
  end
  
 
  def set_one_month  # ページ出力前に1ヶ月分のデータの存在を確認・セットします。
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day] # 対象の月の日数を代入します。
    @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)# ユーザーに紐付く一ヶ月分のレコードを検索し取得します。

    unless one_month.count == @attendances.count # それぞれの件数（日数）が一致するか評価します。
      ActiveRecord::Base.transaction do # トランザクションを開始します。
        one_month.each { |day| @user.attendances.create!(worked_on: day) }# 繰り返し処理により、1ヶ月分の勤怠データを生成します。
      end
    @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
    end

  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to root_url
  end
end
