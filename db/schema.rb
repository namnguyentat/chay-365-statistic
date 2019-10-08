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

ActiveRecord::Schema.define(version: 2019_06_04_014938) do

  create_table "activities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.string "kind", null: false
    t.string "activity_id", null: false
    t.string "timezone", null: false
    t.datetime "start_date_local", null: false
    t.integer "distance", null: false
    t.integer "elapsed_time", null: false
    t.integer "moving_time", null: false
    t.float "pace"
    t.float "race_pace"
    t.integer "year", null: false
    t.integer "month", null: false
    t.integer "week", null: false
    t.integer "total_elevation_gain", null: false
    t.text "data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activities_on_activity_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "challenge_user_mappings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "challenge_id"
    t.integer "target", default: 0
    t.float "total", default: 0.0
    t.integer "point", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_challenge_user_mappings_on_challenge_id"
    t.index ["user_id"], name: "index_challenge_user_mappings_on_user_id"
  end

  create_table "challenges", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.integer "month"
    t.date "start_date"
    t.date "end_date"
    t.integer "min_distance", default: 2000
    t.integer "min_pace", default: 2
    t.integer "max_pace", default: 12
    t.integer "min_trail_pace", default: 2
    t.integer "max_trail_pace", default: 30
    t.integer "min_trail_elevation_gain", default: 300
    t.integer "point_wo_day", default: 0, null: false
    t.integer "integer", default: 0, null: false
    t.integer "point_wo_5k", default: 0, null: false
    t.integer "point_wo_pace8", default: 0, null: false
    t.integer "point_wo_start_5am", default: 0, null: false
    t.integer "point_wo_21day", default: 0, null: false
    t.integer "point_wo_hm", default: 0, null: false
    t.integer "point_wo_fm", default: 0, null: false
    t.integer "point_wo_finish_21day", default: 0, null: false
    t.boolean "wo_limit", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_user_mappings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_user_mappings_on_group_id"
    t.index ["user_id"], name: "index_group_user_mappings_on_user_id"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin"
    t.string "strava_code"
    t.string "strava_token"
    t.string "strava_athlete_id"
    t.datetime "strava_last_sync_at"
    t.datetime "strava_last_token_at"
    t.string "team"
    t.string "strava_refresh_token"
    t.integer "total_point", default: 0, null: false
    t.integer "level", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "activities", "users"
  add_foreign_key "challenge_user_mappings", "challenges"
  add_foreign_key "challenge_user_mappings", "users"
  add_foreign_key "group_user_mappings", "groups"
  add_foreign_key "group_user_mappings", "users"
end
