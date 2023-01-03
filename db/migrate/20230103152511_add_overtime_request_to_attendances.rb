class AddOvertimeRequestToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :estimated_overtime_hours, :datetime
    add_column :attendances, :next_day_overtime, :boolean, default: false
    add_column :attendances, :overtime_work_content, :string
    add_column :attendances, :superior_selector_overtime_request, :string
    add_column :attendances, :overtime_approval_status, :string
    add_column :attendances, :overtime_approval_check, :boolean, default: false
  end
end