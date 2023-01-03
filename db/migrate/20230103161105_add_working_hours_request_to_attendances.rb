class AddWorkingHoursRequestToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :started_at_before, :datetime
    add_column :attendances, :finished_at_before, :datetime
    add_column :attendances, :started_at_edited, :datetime
    add_column :attendances, :finished_at_edited, :datetime
    add_column :attendances, :next_day_working_hours, :boolean, default: false
    add_column :attendances, :superior_selector_working_hours_request, :string
    add_column :attendances, :working_hours_approval_status, :string
    add_column :attendances, :working_hours_approval_check, :boolean, default: false
  end
end
