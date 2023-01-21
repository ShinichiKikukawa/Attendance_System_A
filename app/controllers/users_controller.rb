class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info, :edit_overtime_request,]
  before_action :admin_user, only: [:index, :destroy, :at_work, :edit_basic_info, :update_basic_info]
  before_action :admin_or_correct_user, only: [:edit, :update]
  before_action :admin_impossible, only: :show
  before_action :correct_user, only: :show
  before_action :set_one_month, only: :show
  before_action :superiors, only: :show

  def new
    @user = User.new
  end

  def show # 出勤日数
    @worked_sum = @attendances.where.not(started_at_before: nil)
                                    .or(@attendances.where.not(started_at: nil).where(confirm_superior_attendance_change_request: "承認")).count

    if current_user.superior? # 所属長承認申請のお知らせ（上長ごとに、1ヶ月分の勤怠申請がされている件数をカウント）
      @one_month_request = Attendance.where(selector_one_month_request: current_user.name)
                                    .where(one_month_approval_result: [nil, '']).count
    end

    if current_user.superior? # 勤怠変更申請のお知らせ
      @attendance_change_request = Attendance.where(selector_attendance_change_request: current_user.name)
                                            .where("instructor_attendance_change LIKE ?", "%申請中").count
    end
    
    if current_user.superior? # 残業申請のお知らせ（上長ごとに、残業申請がされている件数をカウント）
      @overtime_request = Attendance.where(selector_overtime_request: current_user.name).count
    end

    respond_to do |format| # csv出力
      format.html
      format.csv do |csv|
        send_attendances_csv(@attendances)
      end
    end
  end
  
  def send_attendances_csv(attendances) # 勤怠csv出力
    bom = "\uFEFF"#文字化け防止
    
    csv_data = CSV.generate(headers: true) do |csv|# CSV.generateとは、対象データを自動的にCSV形式に変換してくれるCSVライブラリの一種
      header = %w(日付 出勤時間 退勤時間) # %w()は、空白で区切って配列を返します
      csv << header # csv << headerは表の列に入る名前を定義します。# 表のカラム名を定義
      
      attendances.each do |day|# column_valuesに代入するカラム値を定義します。 # column_valuesに代入するカラム値を定義
        column_values = [day.worked_on.strftime("%Y年%m月%d日(#{$days_of_the_week[day.worked_on.wday]})"),
          if day.started_at.present? 
            l(day.started_at, format: :time)
          else
            nil
          end,
          if day.finished_at.present? 
            l(day.finished_at, format: :time)
          else
            nil
          end
        ]
        csv << column_values # csv << column_valuesは表の行に入る値を定義します。
      end
    end

    send_data(csv_data, filename: "#{Time.zone.now.strftime('%Y年%m月')}#{User.find(params[:id]).name}勤怠情報.csv") # csv出力のファイル名を定義します。
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザー情報を新規登録しました。"
      redirect_to @user
    else
      flash[:danger] = "ユーザー登録に失敗しました。やり直して下さい。"
      render :new
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def import
    if params[:file].blank?
      flash[:danger] = "CSVファイルが選択されていません。"
    redirect_to users_url
    else
      if User.import(params[:file])
        flash[:success] = "CSVファイルのインポートに成功しました。"
      else
        flash[:danger] = "CSVファイルのインポートに失敗しました。"
      end
      redirect_to users_url
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name}のユーザー情報を更新しました。"
      if current_user.admin?
        redirect_to users_url(current_user)
      else
        redirect_to user_url(current_user)  
      end
    else
      flash[:danger] = "#{@user.name}のユーザー情報を更新出来ませんでした。"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end                                     
  
  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}のユーザー情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}のユーザー情報を更新出来ませんでした。"
    end
    redirect_to users_url
  end

  def at_work # 出勤社員一覧 挙動を確認する。
    @users = User.all
  end    

  private

    def user_params
      params.require(:user).permit(:name, :email, :affiliation, :employee_number, :uid,
                                  :password, :password_confirmation, :basic_work_time,
                                  :designated_work_start_time, :designated_work_end_time)
    end

    def basic_info_params
      params.require(:user).permit(:name, :email, :affiliation, :employee_number, :uid,
                                  :password, :password_confirmation, :basic_work_time,
                                  :designated_work_start_time, :designated_work_end_time)
    end 
end