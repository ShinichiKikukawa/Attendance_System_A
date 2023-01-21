module AttendancesHelper

  def attendance_state(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    # どれにも当てはまらなかった場合はfalseを返します。
    return false
  end

   #出勤時間と退勤時間を受け取り、在社時間を計算して返します。# 在社時間の計算
  def working_time(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))
  end


  # 残業時間計算の日時補正
  def date_correction(worked_on, date)
    date.change(year: worked_on.year, month: worked_on.month, day: worked_on.day)
  end

  # 残業時間の計算
  def overtime(designated_work_end_time, scheduled_end_time)
    format("%.2f", ((scheduled_end_time - designated_work_end_time) / 60) / 60.0)
  end
end
