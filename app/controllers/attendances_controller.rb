class AttendancesController < ApplicationController
  before_action :set_user, only: [:edit_one_month, :update_one_month,
                                  :update_one_month_request,
                                  :edit_attendance_change_request, :update_attendance_change_request,  
                                  :edit_overtime_request, :update_overtime_request,
                                  :attendances_log]
  before_action :logged_in_user, only: [:update, 
                                        :edit_one_month, :update_one_month,
                                        :edit_attendance_change_request, :update_attendance_change_request,
                                        :edit_overtime_request, :update_overtime_request,
                                        :attendance_log]

  before_action :admin_user, only: index
  before_action :correct_user, only: [:update,
                                      :edit_attendance_change_request, :update_attendance_change_request,
                                      :update_one_month_request, 
                                      :edit_overtime_request, :update_overtime_request,
                                      :attendance_log]
  before_action :superior_user, only:[:edit_overtime_approval, :update_overtime_approval, 
                                      :edit_one_month_approval, :update_one_month_approval,
                                      :edit_attendance_change_approval, :update_attendance_change_approval,
                                      :attendance_confirmation]  
  before_action :set_one_month, only:[:edit_attendance_change_request,
                                      :edit_overtime_request,
                                      :attendance_log]
  before_action :superiors, only: [:edit_attendance_change_request, :edit_overtime_request]
  before_action :overtime_request, only:[:edit_overtime_request, :update_overtime_request]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month]

  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"

def index # 出勤中の社員を表示
  @users = User.all
end

  def update # 出退勤打刻
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0), started_at_before: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！出勤時間を登録しました！")
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.started_at.present? && @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0), finished_at_before: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした！退勤時間を登録しました！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end

  def edit_one_month
  end

  def update_one_month
    ActiveRecord::Base.transaction do # トランザクションを開始します。
      attendances_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.assign_attributes(item) #ここでオブジェクトのカラム全体を更新(この時点ではレコードに保存していない)
        attendance.save!(context: :update_one_month)#ここで↑で更新した値をレコードに保存(同時にバリデーションを実行)
      end
    end
    flash[:success] = "1ヶ月分の勤怠情報を更新しました。"# トランザクションが正常に稼働したら出る。
    redirect_to user_url(date: params[:date])
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"# トランザクションが失敗したら出る。
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end

  private

    # 1ヶ月分の勤怠情報を扱います。
    def attendances_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note])[:attendances]
    end

end
