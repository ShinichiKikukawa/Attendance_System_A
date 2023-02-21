class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  $days_of_the_week = %w{日 月 火 水 木 金 土}
  
  def set_user # paramsハッシュからユーザーを取得します。
    @user = User.find(params[:id]) 
  end
  
  def logged_in_user  # ログインユーザー
    unless logged_in?# ログイン済みのユーザーか確認します。
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end

  def admin_user# 管理者ユーザーのみ# システム管理権限所有かどうか判定します。# 管理者ユーザーのみ
    unless current_user.admin?
      flash[:danger] = "参照・編集権限がありません。error-code1"
      redirect_to root_url
    end
  end

  def admin_or_correct_user # ログインユーザーまたは管理者
    @user = User.find(params[:user_id]) if @user.blank?
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "参照・編集権限がありません。error-code2"
      redirect_to users_url
    end
  end
  
  def admin_impossible # 管理者は勤怠画面の表示と編集は不可
    if current_user.admin?
      redirect_to users_url
    end
  end
  
  def correct_user# アクセスしたユーザーが現在ログインしているユーザーか確認します。# ログインユーザーとログイン先が一致しているか？
    @user = User.find(params[:user_id]) if @user.blank?
    unless current_user?(@user)
      if current_user.superior?
        if params[:date].present?
          first_day = params[:date].to_date
          attendances = @user.attendances.where(worked_on: first_day..first_day.end_of_month)
          if attendances.pluck(:selector_one_month_request).include?("#{current_user.name}")
          elsif attendances.pluck(:selector_attendance_change_request).include?("#{current_user.name}")
          elsif attendances.pluck(:selector_overtime_request).include?("#{current_user.name}")
          else
            flash[:danger] = "参照・編集権限がありません。error-code3"
            redirect_to root_url
          end
        else
          flash[:danger] = "参照・編集権限がありません。error-code4"
          redirect_to root_url
        end
      else
        flash[:danger] = "参照・編集権限がありません。error-code5"
        redirect_to root_url
      end
    end
  end

  def correct_user_or_superior
    @user = User.find(params[:id]) if @user.blank?
    unless current_user?(@user) || current_user.superior?
      flash[:danger] = "参照・編集権限がありません。error-code6"
      redirect_to root_url
    end
  end
    
  def superior_user
    redirect_to root_url unless current_user.superior?
  end

  def superiors
    @superiors = User.where(superior: true).where.not(name: @user.name).order(id: :asc)
  end


  def set_one_month  # ページ出力前に1ヶ月分のデータの存在を確認・セットします。
    @first_day = params[:date].nil? ? Date.current.beginning_of_month : params[:date].to_date
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
    redirect_to @user
  end
end
