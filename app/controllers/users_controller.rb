class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :destroy, :edit_basic_info, :update_basic_info]
  before_action :admin_or_correct_user, only: :show
  before_action :set_one_month, only: :show

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
    # csv出力
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_attendances_csv(@attendances)
      end
    end
  end
  
  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
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
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end

  def list_of_employees_at_work
    @users = User.all
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

  private

    def user_params
      params.require(:user).permit(:name, :email, :affiliation, :password, :password_confirmation)
    end

    def basic_info_params
      params.require(:user).permit(:affiliation, :basic_work_time, :work_time)
    end
    
    def send_attendances_csv(attendances)
      bom = "\uFEFF"#文字化け防止
      
      csv_data = CSV.generate do |csv|# CSV.generateとは、対象データを自動的にCSV形式に変換してくれるCSVライブラリの一種
        column_names = %w(日付 出勤時間 退勤時間) # %w()は、空白で区切って配列を返します
        csv << column_names # csv << column_namesは表の列に入る名前を定義します。
        
        attendances.each do |day|# column_valuesに代入するカラム値を定義します。
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
       
          csv << column_values # csv << column_valueshは表の行に入る値を定義します。
        end
      end
   
      send_data(csv_data, filename: "勤怠一覧.csv") # csv出力のファイル名を定義します。
    end
end