# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20230110161437) do

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "instructor"
    t.string "selector_one_month_request"
    t.boolean "one_month_approval_check", default: false
    t.string "confirm_superior_one_month_request"
    t.string "one_month_approval_result"
    t.datetime "started_at_before"
    t.datetime "finished_at_before"
    t.datetime "started_at_approval"
    t.datetime "finished_at_approval"
    t.string "selector_attendance_change_request"
    t.boolean "attendance_change_approval_check", default: false
    t.string "confirm_superior_attendance_change_request"
    t.boolean "next_day_attendance_change", default: false
    t.string "instructor_attendance_change"
    t.datetime "attendance_change_approval_day"
    t.datetime "scheduled_end_time"
    t.boolean "next_day_overtime", default: false
    t.string "work_contents"
    t.string "selector_overtime_request"
    t.boolean "overtime_approval_check", default: false
    t.string "confirm_superior_overtime_request"
    t.string "superior_attendance_log"
    t.string "instructor_attendance_log"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.integer "base_number"
    t.string "base_name"
    t.string "work_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "affiliation"
    t.datetime "basic_work_time", default: "2023-05-28 23:00:00"
    t.datetime "work_time", default: "2023-05-28 22:30:00"
    t.integer "employee_number"
    t.integer "uid"
    t.datetime "designated_work_start_time", default: "2023-01-01 00:00:00"
    t.datetime "designated_work_end_time", default: "2023-01-01 09:00:00"
    t.boolean "superior", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
