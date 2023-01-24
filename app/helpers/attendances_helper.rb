module AttendancesHelper

  def attendance_state(attendance) # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    
    return false # どれにも当てはまらなかった場合はfalseを返します。
  end
  
  def working_time(start, finish)  # 在社時間の計算 #出勤時間と退勤時間を受け取り、在社時間を計算して返します。# 在社時間の計算
    format("%.2f", (((finish - start) / 60) / 60.0))
  end

  def date_correction(worked_on, date) # 残業時間計算の日時補正
    date.change(year: worked_on.year, month: worked_on.month, day: worked_on.day)
  end

  def overtime(designated_work_end_time, scheduled_end_time) # 残業時間の計算
    format("%.2f", ((scheduled_end_time - designated_work_end_time) / 60) / 60.0)
  end
end
