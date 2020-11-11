# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_11_172642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "pin", null: false
    t.integer "professor_id", null: false
    t.integer "maximum_group_member"
    t.integer "minimum_group_member"
    t.boolean "has_group", default: false
    t.boolean "is_voting", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state", default: "created"
    t.boolean "withProject"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "project_id"
    t.string "group_name"
    t.integer "students_id", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "in_groups", force: :cascade do |t|
    t.integer "group_id"
    t.integer "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_id"
  end

  create_table "preference_weights", force: :cascade do |t|
    t.integer "course_id"
    t.integer "subject_proficiency"
    t.integer "dream_partner"
    t.integer "time_zone"
    t.integer "schedule"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_voting"
  end

  create_table "preferences", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "course_id", null: false
    t.integer "subject_matter_proficiency"
    t.string "time_zone", default: "UTC"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "dream_partner", default: [], array: true
    t.string "schedule"
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name"
    t.integer "course_id", null: false
    t.text "description"
    t.boolean "is_active", default: false
    t.integer "number_of_likes", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "added_by"
  end

  create_table "takings", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state", default: "created"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.integer "current_course_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "course_id", null: false
    t.integer "vote_first", default: -1
    t.integer "vote_second", default: -1
    t.integer "vote_third", default: -1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
