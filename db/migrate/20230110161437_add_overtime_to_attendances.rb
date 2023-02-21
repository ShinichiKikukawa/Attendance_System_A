class AddOvertimeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :instructor, :string


    add_column :attendances, :selector_one_month_request, :string
    add_column :attendances, :one_month_approval_check, :boolean, default: false
    add_column :attendances, :confirm_superior_one_month_request, :string
    add_column :attendances, :one_month_approval_result, :string
    
    
    add_column :attendances, :started_at_before, :datetime
    add_column :attendances, :finished_at_before, :datetime
    add_column :attendances, :started_at_approval, :datetime
    add_column :attendances, :finished_at_approval, :datetime
    add_column :attendances, :selector_attendance_change_request, :string
    add_column :attendances, :attendance_change_approval_check, :boolean, default: false
    add_column :attendances, :confirm_superior_attendance_change_request, :string
    add_column :attendances, :next_day_attendance_change, :boolean, default: false
    add_column :attendances, :instructor_attendance_change, :string
    add_column :attendances, :attendance_change_approval_day, :datetime


    add_column :attendances, :scheduled_end_time, :datetime
    add_column :attendances, :next_day_overtime, :boolean, default: false
    add_column :attendances, :work_contents, :string
    add_column :attendances, :selector_overtime_request, :string
    add_column :attendances, :overtime_approval_check, :boolean, default: false
    add_column :attendances, :confirm_superior_overtime_request, :string
    

    add_column :attendances, :superior_attendance_log, :string
    add_column :attendances, :instructor_attendance_log, :string
  end
end
