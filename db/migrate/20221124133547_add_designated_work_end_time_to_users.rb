class AddDesignatedWorkEndTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :designated_work_end_time, :datetime, default: "2023-1-1 9:00:00"
  end
end
