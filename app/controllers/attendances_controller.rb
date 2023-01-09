class AttendancesController < ApplicationController
  before_action :set_user, only: [:edit_one_month, :update_one_month]
  before_action :set_user_id, only: [:update, :edit_overtime_request, :update_overtime_request, :edit_overtime_notice, :update_overtime_notice, :edit_attendances_change_approval, :update_attendances_change_approval, :edit_one_month_approval, :update_one_month_approval, :attendance_log]
  before_action :logged_in_user, only: [:update, :edit_one_month, :update_one_month]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month]
  before_action :set_one_month, only: :edit_one_month
  before_action :set_attendance, only: [:update, :edit_overtime_request, :update_overtime_request]

  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"

  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
   
    if @attendance.started_at.nil?  # 出勤時間が未登録であることを判定します。
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！出勤時間を登録しました。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした！退勤時間を登録しました。"
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
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐。
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"# トランザクションが失敗したら出る。
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end


  
  def edit_overtime_request # 残業申請のモーダルウィンドウ表示
    @superiors = User.where(superior: true).where.not(id: @user.id)
  end

  
  def update_overtime_request # 残業申請のモーダルウィンドウ更新
    if overtime_request_params[:scheduled_end_time].blank? || overtime_request_params[:business_process_content].blank? || overtime_request_params[:overtime_request_superior].blank?
      flash[:danger] = "終了予定時間、業務処理内容、または、指示者確認㊞がありません"
    else
      if overtime_request_params[:estimated_overtime_hours].present? && overtime_request_params[:overtime_work_content].present? && overtime_request_params[:superior_selector_overtime_request].present?
        params[:attendance][:overtime_approval_status] = "申請中"
        @attendance.update(overtime_request_params)
        flash[:success] = "残業申請をしました"
      else
        flash[:danger] = "残業申請が正しくありません"
      end
    end
    redirect_to @user
  end

  private

    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    def attendances_params # 1ヶ月分の勤怠情報を扱う。
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note])[:attendances]
    end

    # 残業申請
    def overtime_request_params
      params.require(:attendance).permit([:estimated_overtime_hours, :next_day_overtime, :overtime_work_content, :superior_selector_overtime_request, :overtime_approval_status])
    end

end
