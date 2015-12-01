# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151021115402) do

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "name",                   limit: 255
    t.string   "role",                   limit: 255
    t.string   "mobile_number",          limit: 255
    t.boolean  "is_superadmin",          limit: 1,   default: false
    t.integer  "client_id",              limit: 4
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "oauth_tocken",           limit: 255
    t.datetime "oauth_expires_at"
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["provider"], name: "index_admin_users_on_provider", using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  add_index "admin_users", ["uid"], name: "index_admin_users_on_uid", using: :btree

  create_table "clients", force: :cascade do |t|
    t.integer  "admin_user_id",     limit: 4
    t.string   "organisation_name", limit: 255
    t.string   "address",           limit: 255
    t.string   "city",              limit: 255
    t.string   "state",             limit: 255
    t.string   "country",           limit: 255
    t.integer  "zipcode",           limit: 4
    t.string   "landline_number",   limit: 255
    t.string   "mobile_number",     limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "entry_options", force: :cascade do |t|
    t.string   "entry_option_name", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "participants", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "participant_name",       limit: 255
    t.string   "participant_number",     limit: 255
    t.integer  "entry_option_id",        limit: 4
    t.string   "secure_key",             limit: 255
    t.string   "answer",                 limit: 255
    t.string   "userkey",                limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "oauth_tocken",           limit: 255
    t.datetime "oauth_expires_at"
    t.integer  "admin_user_id",          limit: 4
    t.integer  "sweepstake_id",          limit: 4
  end

  add_index "participants", ["provider"], name: "index_participants_on_provider", using: :btree
  add_index "participants", ["reset_password_token"], name: "index_participants_on_reset_password_token", unique: true, using: :btree
  add_index "participants", ["uid"], name: "index_participants_on_uid", using: :btree
  add_index "participants", ["userkey"], name: "index_participants_on_userkey", unique: true, using: :btree

  create_table "sweepstake_participants", force: :cascade do |t|
    t.integer  "sweepstake_id",  limit: 4
    t.integer  "participant_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "sweepstakes", force: :cascade do |t|
    t.integer  "admin_user_id",            limit: 4
    t.string   "sweepstake_name",          limit: 255
    t.string   "prize_name",               limit: 255
    t.string   "prize_image_file_name",    limit: 255
    t.string   "prize_image_content_type", limit: 255
    t.integer  "prize_image_file_size",    limit: 4
    t.datetime "prize_image_updated_at"
    t.integer  "winner_count",             limit: 4
    t.integer  "entry_option_id",          limit: 4
    t.string   "question",                 limit: 255
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "rules_file_name",          limit: 255
    t.string   "rules_content_type",       limit: 255
    t.integer  "rules_file_size",          limit: 4
    t.datetime "rules_updated_at"
    t.string   "bg_color",                 limit: 255
    t.string   "status",                   limit: 255
    t.string   "sweepstake_link",          limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "secure_key",               limit: 255
    t.string   "theme",                    limit: 255
  end

  create_table "winners", force: :cascade do |t|
    t.integer  "sweepstake_id",  limit: 4
    t.integer  "participant_id", limit: 4
    t.integer  "admin_user_id",  limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
