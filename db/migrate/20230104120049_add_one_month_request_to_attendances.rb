class AddOneMonthRequestToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :superior_selector_one_month_request, :string
    add_column :attendances, :one_month_request_status, :string
    add_column :attendances, :one_month_approval_status, :string
    add_column :attendances, :one_month_approval_check, :boolean, default: false
  end
end
