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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120127162927) do

  create_table "activities", :force => true do |t|
    t.integer  "activity_type_id"
    t.integer  "user_id"
    t.datetime "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["activity_type_id"], :name => "index_activities_on_activity_type_id"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "activity_types", :force => true do |t|
    t.string   "name"
    t.integer  "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activity_types", ["tag"], :name => "index_activity_types_on_tag", :unique => true

  create_table "devices", :force => true do |t|
    t.string   "mac_address"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devices", ["user_id"], :name => "index_devices_on_user_id"

  create_table "heart_rate_summaries", :force => true do |t|
    t.date     "date"
    t.integer  "occurrences"
    t.integer  "user_id"
    t.integer  "heart_rate_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "heart_rate_summaries", ["heart_rate_type_id"], :name => "index_heart_rate_summaries_on_heart_rate_type_id"
  add_index "heart_rate_summaries", ["user_id"], :name => "index_heart_rate_summaries_on_user_id"

  create_table "heart_rate_types", :force => true do |t|
    t.string   "name"
    t.integer  "min_value"
    t.integer  "max_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recover_passwords", :force => true do |t|
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recover_passwords", ["token"], :name => "index_recover_passwords_on_token", :unique => true
  add_index "recover_passwords", ["user_id"], :name => "index_recover_passwords_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "display_name"
    t.string   "email"
    t.integer  "last_heart_rate"
    t.boolean  "online_status"
    t.integer  "last_battery_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
