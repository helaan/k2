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

ActiveRecord::Schema.define(version: 20180221114049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "server_id"
    t.integer "account_id"
    t.integer "solvedProblems"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "server_id"], name: "index_accounts_on_account_id_and_server_id", unique: true
    t.index ["server_id"], name: "index_accounts_on_server_id"
    t.index ["user_id", "server_id"], name: "index_accounts_on_user_id_and_server_id", unique: true
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "problems", id: :serial, force: :cascade do |t|
    t.integer "server_id"
    t.string "problem_id"
    t.string "short_name"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
    t.index ["server_id", "problem_id"], name: "index_problems_on_server_id_and_problem_id", unique: true
    t.index ["server_id", "short_name"], name: "index_problems_on_server_id_and_short_name", unique: true
    t.index ["server_id"], name: "index_problems_on_server_id"
  end

  create_table "servers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "api_type"
    t.string "api_endpoint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "last_submission"
    t.integer "started_at"
    t.integer "contest_id"
  end

  create_table "submissions", id: :serial, force: :cascade do |t|
    t.integer "problem_id"
    t.integer "account_id"
    t.integer "submission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "score"
    t.integer "status", default: 0
    t.string "language"
    t.index ["account_id"], name: "index_submissions_on_account_id"
    t.index ["problem_id", "submission_id"], name: "index_submissions_on_problem_id_and_submission_id", unique: true
    t.index ["problem_id"], name: "index_submissions_on_problem_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.boolean "admin", default: false
    t.boolean "ldap_user", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "webhooks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "hook_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
