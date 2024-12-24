# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2019_03_07_114631) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.string "street", limit: 255
    t.string "city", limit: 255
    t.string "state", limit: 255
    t.string "zipcode", limit: 255
    t.string "home_phone", limit: 255
    t.string "cell_phone", limit: 255
    t.string "email", limit: 255
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "book_charges", id: :serial, force: :cascade do |t|
    t.integer "grade_id", null: false
    t.integer "school_year_id", null: false
    t.integer "book_charge_in_cents", default: 2000, null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "families", id: :serial, force: :cascade do |t|
    t.integer "parent_one_id"
    t.integer "parent_two_id"
    t.integer "address_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "ccca_lifetime_member", default: false, null: false
  end

  create_table "families_children", id: false, force: :cascade do |t|
    t.integer "family_id"
    t.integer "child_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "gateway_transactions", id: :serial, force: :cascade do |t|
    t.integer "registration_payment_id"
    t.integer "amount_in_cents"
    t.string "credit_card_type", limit: 255
    t.string "credit_card_last_digits", limit: 255
    t.string "approval_status", limit: 255
    t.string "error_message", limit: 255
    t.string "approval_code", limit: 255
    t.string "reference_number", limit: 255
    t.boolean "credit", default: false, null: false
    t.text "response_dump"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "grades", id: :serial, force: :cascade do |t|
    t.string "chinese_name", limit: 255
    t.string "english_name", limit: 255
    t.string "short_name", limit: 255
    t.integer "next_grade"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "jersey_number_prefix", limit: 255
  end

  create_table "in_person_registration_transactions", id: :serial, force: :cascade do |t|
    t.integer "registration_payment_id"
    t.integer "recorded_by_id"
    t.string "payment_method", limit: 255
    t.string "check_number", limit: 255
    t.text "note"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "instructor_assignments", id: :serial, force: :cascade do |t|
    t.integer "school_year_id"
    t.integer "school_class_id"
    t.integer "instructor_id"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "role", limit: 255
  end

  create_table "jersey_numbers", id: :serial, force: :cascade do |t|
    t.integer "person_id"
    t.integer "school_year_id"
    t.integer "number"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "prefix", limit: 255
  end

  create_table "library_book_checkouts", id: :serial, force: :cascade do |t|
    t.integer "library_book_id", null: false
    t.integer "checked_out_by_id", null: false
    t.date "checked_out_date", null: false
    t.date "return_date"
    t.text "note"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "library_books", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.string "description", limit: 255
    t.string "publisher", limit: 255
    t.string "book_type", limit: 255
    t.boolean "checked_out"
    t.text "note"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "manual_transactions", id: :serial, force: :cascade do |t|
    t.integer "recorded_by_id"
    t.integer "student_id"
    t.integer "transaction_by_id"
    t.integer "amount_in_cents", default: 0, null: false
    t.string "transaction_type", limit: 255
    t.date "transaction_date"
    t.string "payment_method", limit: 255
    t.string "check_number", limit: 255
    t.text "note"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "people", id: :serial, force: :cascade do |t|
    t.string "english_last_name", limit: 255
    t.string "english_first_name", limit: 255
    t.string "chinese_name", limit: 255
    t.string "gender", limit: 255
    t.integer "birth_year"
    t.integer "birth_month"
    t.string "native_language", limit: 255
    t.integer "address_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "registration_payments", id: :serial, force: :cascade do |t|
    t.integer "school_year_id"
    t.integer "paid_by_id"
    t.integer "pva_due_in_cents"
    t.integer "ccca_due_in_cents"
    t.integer "grand_total_in_cents"
    t.boolean "paid", default: false, null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "request_in_person", default: false, null: false
    t.integer "elective_class_due_in_cents", default: 0, null: false
  end

  create_table "registration_preferences", id: :serial, force: :cascade do |t|
    t.integer "school_year_id"
    t.integer "student_id"
    t.integer "entered_by_id"
    t.integer "previous_grade_id"
    t.integer "grade_id"
    t.string "school_class_type", limit: 255
    t.integer "elective_class_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "re_register_elective_class_id", default: 0
  end

  create_table "rights", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "controller", limit: 255
    t.string "action", limit: 255
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "rights_roles", id: false, force: :cascade do |t|
    t.integer "right_id"
    t.integer "role_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "school_class_active_flags", id: :serial, force: :cascade do |t|
    t.integer "school_class_id"
    t.integer "school_year_id"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["school_class_id"], name: "index_school_class_active_flags_on_school_class_id"
    t.index ["school_year_id"], name: "index_school_class_active_flags_on_school_year_id"
  end

  create_table "school_classes", id: :serial, force: :cascade do |t|
    t.string "english_name", limit: 255
    t.string "chinese_name", limit: 255
    t.string "description", limit: 255
    t.string "location", limit: 255
    t.integer "max_size"
    t.integer "min_age"
    t.integer "max_age"
    t.integer "grade_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "short_name", limit: 255
    t.string "school_class_type", limit: 255
  end

  create_table "school_years", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.date "registration_start_date"
    t.date "registration_75_percent_date"
    t.date "registration_50_percent_date"
    t.date "registration_end_date"
    t.date "refund_75_percent_date"
    t.date "refund_50_percent_date"
    t.date "refund_25_percent_date"
    t.date "refund_end_date"
    t.integer "age_cutoff_month"
    t.integer "registration_fee_in_cents", default: 2000, null: false
    t.integer "tuition_in_cents", default: 38000, null: false
    t.integer "pva_membership_due_in_cents", default: 1500, null: false
    t.integer "ccca_membership_due_in_cents", default: 2000, null: false
    t.date "early_registration_end_date"
    t.integer "early_registration_tuition_in_cents", default: 38000, null: false
    t.integer "tuition_discount_for_three_or_more_child_in_cents", default: 3800, null: false
    t.integer "tuition_discount_for_pre_k_in_cents", default: 4000, null: false
    t.integer "previous_school_year_id"
    t.date "early_registration_start_date"
    t.integer "tuition_discount_for_instructor_in_cents", default: 0, null: false
    t.date "refund_90_percent_date"
    t.boolean "auto_class_assignment", default: false, null: false
    t.integer "elective_class_fee_in_cents", default: 5000, null: false
    t.integer "parent_and_student_class_fee_in_cents", default: 0, null: false
    t.integer "early_registration_parent_and_student_class_fee_in_cents", default: 0, null: false
  end

  create_table "staff_assignments", id: :serial, force: :cascade do |t|
    t.integer "school_year_id", null: false
    t.integer "person_id", null: false
    t.string "role", limit: 255
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "student_class_assignments", id: :serial, force: :cascade do |t|
    t.integer "student_id"
    t.integer "grade_id"
    t.integer "school_class_id"
    t.integer "elective_class_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "school_year_id"
    t.index ["school_year_id"], name: "index_student_class_assignments_on_school_year_id"
  end

  create_table "student_fee_payments", id: :serial, force: :cascade do |t|
    t.integer "registration_payment_id"
    t.integer "student_id"
    t.integer "registration_fee_in_cents"
    t.integer "tuition_in_cents"
    t.integer "book_charge_in_cents"
    t.boolean "early_registration", default: false, null: false
    t.boolean "multiple_child_discount", default: false, null: false
    t.boolean "pre_k_discount", default: false, null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "prorate_75", default: false, null: false
    t.boolean "prorate_50", default: false, null: false
    t.boolean "instructor_discount", default: false, null: false
    t.boolean "staff_discount", default: false, null: false
    t.integer "elective_class_fee_in_cents", default: 0, null: false
  end

  create_table "student_final_marks", id: :serial, force: :cascade do |t|
    t.integer "school_year_id", null: false
    t.integer "school_class_id", null: false
    t.integer "student_id", null: false
    t.integer "top_three"
    t.boolean "progress_award", default: false, null: false
    t.boolean "spirit_award", default: false, null: false
    t.boolean "attendance_award", default: false, null: false
    t.float "total_score"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "talent_award"
  end

  create_table "student_status_flags", id: :serial, force: :cascade do |t|
    t.integer "student_id"
    t.integer "school_year_id"
    t.date "last_status_change_date"
    t.boolean "registered", default: false, null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "timed_tokens", id: :serial, force: :cascade do |t|
    t.string "token", limit: 255
    t.integer "person_id"
    t.datetime "expiration", precision: nil
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "track_event_heats", id: :serial, force: :cascade do |t|
    t.integer "track_event_program_id", null: false
    t.string "gender", limit: 255
    t.integer "run_order"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "track_event_programs", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.string "event_type", limit: 255
    t.string "program_type", limit: 255
    t.integer "school_year_id"
    t.integer "grade_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "team_size"
    t.integer "sort_key"
    t.boolean "mixed_gender", default: false, null: false
    t.string "division", limit: 255
  end

  create_table "track_event_signups", id: :serial, force: :cascade do |t|
    t.integer "track_event_program_id"
    t.integer "student_id"
    t.integer "parent_id"
    t.string "group_name", limit: 255
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "track_event_team_id"
    t.boolean "filler", default: false, null: false
    t.integer "track_event_heat_id"
    t.integer "track_time"
    t.float "score"
  end

  create_table "track_event_teams", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "track_event_program_id", null: false
    t.string "gender", limit: 255
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "filler", default: false, null: false
    t.integer "track_event_heat_id"
    t.integer "track_time"
    t.boolean "pair_winner", default: false, null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", limit: 255
    t.string "password_hash", limit: 255
    t.string "password_salt", limit: 255
    t.integer "person_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "withdraw_request_details", id: :serial, force: :cascade do |t|
    t.integer "withdraw_request_id"
    t.integer "student_id"
    t.integer "refund_registration_fee_in_cents"
    t.integer "refund_tuition_in_cents"
    t.integer "refund_book_charge_in_cents"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "refund_elective_class_fee_in_cents", default: 0, null: false
    t.string "elective_class_only", limit: 5, default: "N"
    t.integer "elective_class_fee_in_cents", default: 0, null: false
  end

  create_table "withdraw_requests", id: :serial, force: :cascade do |t|
    t.integer "request_by_id"
    t.string "request_by_name", limit: 255
    t.string "request_by_address", limit: 255
    t.integer "school_year_id"
    t.integer "refund_pva_due_in_cents"
    t.integer "refund_ccca_due_in_cents"
    t.integer "refund_grand_total_in_cents"
    t.string "status_code", limit: 255
    t.integer "status_by_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "request_by_home_phone", limit: 255
  end

  create_table "withdrawal_records", id: :serial, force: :cascade do |t|
    t.integer "student_id"
    t.integer "school_year_id"
    t.integer "grade_id"
    t.integer "school_class_id"
    t.integer "elective_class_id"
    t.date "registration_date"
    t.date "withdrawal_date"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end
end
