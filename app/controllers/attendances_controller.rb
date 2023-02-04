class AttendancesController < ApplicationController
  before_action :set_user, only: [:update_one_month_request,
                                  :edit_one_month_approval,
                                  :edit_attendance_change_request, :update_attendance_change_request,
                                  :edit_attendance_change_approval,
                                  :edit_overtime_request, :update_overtime_request,
                                  :edit_overtime_approval,
                                  :attendance_log]
  before_action :logged_in_user, only: [:update, 
                                        :edit_attendance_change_request, :update_attendance_change_request,
                                        :edit_overtime_request, :update_overtime_request,
                                        :attendance_log]
  #before_action :admin_user, only: index
  before_action :correct_user, only: [:update,
                                      :update_one_month_request,
                                      :edit_attendance_change_request, :update_attendance_change_request,
                                      :edit_overtime_request, :update_overtime_request,
                                      :attendance_log]
  before_action :superior_user, only:[:edit_one_month_approval, :update_one_month_approval,
                                      :edit_attendance_change_approval, :update_attendance_change_approval,
                                      :edit_overtime_approval, :update_overtime_approval, 
                                      :attendance_confirmation]  
  before_action :set_one_month, only:[:edit_attendance_change_request,
                                      :edit_overtime_request,
                                      :attendance_log]
  before_action :superiors, only: [:edit_attendance_change_request, :edit_overtime_request]
  before_action :overtime_request, only:[:edit_overtime_request, :update_overtime_request]

  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"

  def index # 出勤中の社員を表示
    @users = User.all.order("id ASC")
  end
  
  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    if @attendance.started_at.nil? # 出勤時間が未登録であることを判定します。
      if @attendance.update(started_at: Time.current.change(sec: 0), started_at_before: Time.current.change(sec: 0))
        flash[:success] = "おはようございます! 出勤時間を登録しました!"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.started_at.present? && @attendance.finished_at.nil?
      if @attendance.update(finished_at: Time.current.change(sec: 0), finished_at_before: Time.current.change(sec: 0))
        flash[:success] = "お疲れ様でした! 退勤時間を登録しました!"
      else
        flash[:danger] = UPDATE_ERROR_MSG  
      end
    end
    redirect_to @user
  end

  def edit_one_month_request #1ヶ月分の勤怠申請
  end

  def update_one_month_request #1ヶ月分の勤怠更新
    one_month_request_params.each do |id, item|
      attendance = Attendance.find(id)
      attendance.one_month_approval_result = nil
      if one_month_request_params[id][:selector_one_month_request].present?
        attendance.confirm_superior_one_month_request = nil
        attendance.one_month_approval_check = nil
        if attendance.update(item)
          flash[:success] = "#{attendance.selector_one_month_request}へ1ヶ月分の勤怠を申請しました。"
        else
          flash[:danger] = "1ヶ月分の勤怠申請に失敗しました。"
        end
      else
        flash[:danger] = "所属長を選択してください。"
      end
        redirect_to user_url(@user, date: attendance.worked_on.beginning_of_month)
    end
  end

  def edit_one_month_approval # 1ヶ月分の勤怠承認
    @users = User.includes(:attendances).where(attendances: {selector_one_month_request: current_user.name})
                                        .where(attendances: {one_month_approval_result: [nil, '']})
                                        .order("attendances.worked_on")
  end

  def update_one_month_approval # 1ヶ月分の勤怠承認更新
    one_month_approval_params.each do |id, item|
      attendance = Attendance.find(id)
      user = User.find(attendance.user_id)
      if one_month_approval_params[id][:one_month_approval_check] == "true"
        if one_month_approval_params[id][:confirm_superior_one_month_request] == "承認"
          attendance.one_month_approval_result = "#{current_user.name}から承認済"
        elsif one_month_approval_params[id][:confirm_superior_one_month_request] == "否認"
          attendance.one_month_approval_result = "#{current_user.name}から否認"
        elsif one_month_approval_params[id][:confirm_superior_one_month_request] == "なし"
          attendance.one_month_approval_result = "#{current_user.name}からなし"
        else one_month_approval_params[id][:confirm_superior_one_month_request] == "申請中"
          attendance.one_month_approval_result = "#{current_user.name}から保留"
        end
        attendance.selector_one_month_request = nil
        if attendance.update(item)
          flash[:success] = "変更を送信しました。"
        else
          flash[:danger] = "変更を送信できませんでした。"
        end
      end
    end
    redirect_to user_url(current_user)
  end

  
  def edit_attendance_change_request # 勤怠の変更内容を申請する。
  end

  def update_attendance_change_request # 勤怠の変更内容を更新する。 #ここ１
    a_count = 0
    ActiveRecord::Base.transaction do
      attendance_change_request_params.each do |id, item|
        attendance = Attendance.find(id)
        if attendance_change_request_params[id][:selector_attendance_change_request].present?
          attendance.confirm_superior_attendance_change_request = nil
          attendance.instructor_attendance_change = "#{attendance_change_request_params[id][:selector_attendance_change_request]}へ勤怠変更申請中"
          attendance.instructor_attendance_log = attendance_change_request_params[id][:selector_attendance_change_request]
          attendance.attendance_change_approval_check = false
        end
        
        if item[:selector_attendance_change_request].present?
          if item[:started_at].blank? && item[:finished_at].blank?
            flash[:danger] = "出勤時間、退勤時間を入力してください。error-code0"
            redirect_to attendances_edit_attendance_change_request_user_url(date: params[:date])
            return
          elsif item[:started_at].blank? && item[:finished_at].present?
            flash[:danger] = "出勤時間を入力してください。error-code1"
            redirect_to attendances_edit_attendance_change_request_user_url(date: params[:date])
            return
          elsif item[:started_at].present? && item[:finished_at].blank?
            flash[:danger] = "退勤時間を入力してください。error-code2"
            redirect_to attendances_edit_attendance_change_request_user_url(date: params[:date])
            return
          elsif item[:started_at].present? && item[:finished_at].present? && item[:started_at].to_s > item[:finished_at].to_s
            flash[:danger] = "退勤後に出勤はできません。出勤時間と退勤時間を正確に入力してください。error-code3"
            redirect_to attendances_edit_attendance_change_request_user_url(date: params[:date])
            return
          elsif item[:note].blank? 
            flash[:danger] = "備考欄には理由などの入力が必要です。error-code4"
            redirect_to attendances_edit_attendance_change_request_user_url(date: params[:date])
            return
          end
          a_count += 1
          attendance.update!(item)
        end
      end
      if a_count > 0
        flash[:success] = "有効な勤怠の変更申請を#{a_count}件、送信しました。(無効なものは却下してあります。)"
        redirect_to user_url(date: params[:date])
        return
      else
        flash[:danger] = "上長を選択してください。error-code5"
        redirect_to attendances_edit_attendance_change_request_user_url(date: params[:date])
        return
      end
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあったため、更新をキャンセルしました。error-code2"
    redirect_to attendances_edit_attendance_change_request_user_url(date: params[:date])
  end

  def edit_attendance_change_approval # 勤怠の変更内容を承認する。
    @users = User.includes(:attendances).where(attendances: { selector_attendance_change_request: current_user.name })
                                        .where("instructor_attendance_change LIKE ?", "%申請中").order("attendances.worked_on")
  end

  def update_attendance_change_approval # 勤怠の変更内容の承認を更新する。
    ActiveRecord::Base.transaction do
      attendance_change_approval_params.each do |id, item|
        attendance = Attendance.find(id)
        user = User.find(attendance.user_id)
        if attendance_change_approval_params[id][:attendance_change_approval_check] == "true"
          if attendance_change_approval_params[id][:confirm_superior_attendance_change_request] == "承認"
            attendance.instructor_attendance_change = "勤怠変更承認済"
            attendance.selector_attendance_change_request = nil
          elsif attendance_change_approval_params[id][:confirm_superior_attendance_change_request] == "否認"
            attendance.instructor_attendance_change = "勤怠変更否認"
            attendance_change_approval_params[id][:started_at] = nil
            attendance_change_approval_params[id][:finished_at] = nil
            attendance_change_approval_params[id][:next_day_attendance_change] = nil
            attendance.selector_attendance_change_request = nil
          elsif attendance_change_approval_params[id][:confirm_superior_attendance_change_request] == "申請中"
            attendance.instructor_attendance_change = "勤怠変更申請中"
          elsif attendance_change_approval_params[id][:confirm_superior_attendance_change_request] == "なし"
            attendance.instructor_attendance_change = "勤怠変更なし"
            attendance_change_approval_params[id][:started_at] = nil
            attendance_change_approval_params[id][:finished_at] = nil
            attendance_change_approval_params[id][:next_day_attendance_change] = nil
            attendance.selector_attendance_change_request = nil
          end
          attendance.attendance_change_approval_day = Date.current
          
          if attendance.update!(item)
            flash[:success] = "勤怠変更申請の結果を送信しました。"
          end
        end
      end
    end
    redirect_to user_url(current_user)
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "勤怠変更申請の送信に失敗しました。"
    redirect_to user_url(current_user)
  end

  def edit_overtime_request # 残業申請
    @user = User.find(params[:id])
    @attendance = @user.attendances.find_by(worked_on: params[:date]) 
  end

  def update_overtime_request # 残業申請更新
    overtime_request_params.each do |id, item|
      attendance = Attendance.find(id)

    if overtime_request_params[id][:scheduled_end_time].blank? || overtime_request_params[id][:work_contents].blank? || overtime_request_params[id][:selector_overtime_request].blank?
      flash[:danger] = "終了予定時間、業務内容、または、指示者確認欄がありません。"
    else
      attendance.instructor = "#{overtime_request_params[id][:selector_overtime_request]}へ残業申請中"
      if attendance.update(item)
        flash[:success] = "#{attendance.selector_overtime_request}への残業申請が完了しました。"
      else
      flash[:danger] = "残業申請に失敗しました。無効な入力、もしくは、未入力がないか確認してください。"
      end
    end
    redirect_to user_url(@user, date: attendance.worked_on.beginning_of_month)
  end
  end

  def edit_overtime_approval # 残業承認
    @users = User.includes(:attendances).where(attendances: { selector_overtime_request: current_user.name })
              .order("attendances.worked_on")
  end

  def update_overtime_approval
    overtime_approval_params.each do |id, item|
      attendance = Attendance.find(id)
      user = User.find(attendance.user_id)
      if overtime_approval_params[id][:overtime_approval_check] == "true"
        if overtime_approval_params[id][:confirm_superior_overtime_request] == "承認"
          attendance.instructor = "残業承認済"
          attendance.selector_overtime_request = nil
        elsif overtime_approval_params[id][:confirm_superior_overtime_request] == "否認"
          attendance.instructor = "残業否認"
          attendance.selector_overtime_request = nil
        elsif overtime_approval_params[id][:confirm_superior_overtime_request] == "なし"
          attendance.scheduled_end_time = nil
          attendance.next_day_overtime = nil
          attendance.work_contents = nil
          attendance.instructor = "残業なし"
          attendance.selector_overtime_request = nil
        else overtime_approval_params[id][:confirm_superior_overtime_request] == "申請中"
          attendance.instructor = "残業申請中"
        end
        if attendance.update(item)
          flash[:success] = "残業申請の結果を送信しました。"
        end
      end
    end
      redirect_to user_url(current_user)
  end


  def attendance_confirmation # 上長勤怠確認
  end


  def attendance_log # 勤怠ログ
    if params[:attendance].present?
      @search_result = params[:attendance]
      date = Date.new @search_result["worked_on(1i)"].to_i, @search_result["worked_on(2i)"].to_i, @search_result["worked_on(3i)"].to_i
      search_date = date.strftime('%Y-%m')

      @attendances = @user.attendances.where(attendances: { confirm_superior_attendance_change_request: "承認" })
                                      .where( "cast(worked_on as text) LIKE ?", "#{search_date}%" )
                                      .order(:worked_on)
    end
  end

    # def edit_one_month
    # end

  # def update_one_month
  #   ActiveRecord::Base.transaction do # トランザクションを開始します。
  #     attendances_params.each do |id, item|
  #       attendance = Attendance.find(id)
  #       attendance.assign_attributes(item) #ここでオブジェクトのカラム全体を更新(この時点ではレコードに保存していない)
  #       attendance.save!(context: :update_one_month)#ここで↑で更新した値をレコードに保存(同時にバリデーションを実行)
  #     end
  #   end
  #   flash[:success] = "1ヶ月分の勤怠情報を更新しました。"# トランザクションが正常に稼働したら出る。
  #   redirect_to user_url(date: params[:date])
  # rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
  #   flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"# トランザクションが失敗したら出る。
  #   redirect_to attendances_edit_one_month_user_url(date: params[:date])
  # end

  private
    def one_month_request_params
      params.require(:user).permit(attendance: :selector_one_month_request)[:attendance]
    end

    def one_month_approval_params
      params.require(:user).permit(attendances: [:confirm_superior_one_month_request, :one_month_approval_check])[:attendances]
    end

    def attendance_change_request_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :next_day_attendance_change, :note, :selector_attendance_change_request])[:attendances]
    end

    def attendance_change_approval_params
      params.require(:user).permit(attendances: [:confirm_superior_attendance_change_request, :attendance_change_approval_check])[:attendances]
    end

    def overtime_request_params
      params.require(:user).permit(attendances: [:scheduled_end_time, :next_day_overtime, :work_contents, :instructor, :selector_overtime_request])[:attendances]
    end

    def overtime_approval_params
      params.require(:user).permit(attendances: [:user_id, :confirm_superior_overtime_request, :overtime_approval_check])[:attendances]
    end

    def overtime_request
      @attendance = @user.attendances.find_by(worked_on: params[:date])
    end

end
