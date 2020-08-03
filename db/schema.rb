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

ActiveRecord::Schema.define(version: 20200217184119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_modules", force: :cascade do |t|
    t.string "module"
    t.string "controller"
    t.json "actions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "command_posts", force: :cascade do |t|
    t.string "description"
    t.string "acronym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "command_posts_events", id: false, force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "command_post_id", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "description"
    t.datetime "start_time"
    t.datetime "final_time"
    t.integer "occurrence_interval"
    t.integer "work_shift_amount"
    t.bigint "sac_city_id", null: false
    t.bigint "sgp_ome_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sac_city_id"], name: "index_events_on_sac_city_id"
    t.index ["sgp_ome_id"], name: "index_events_on_sgp_ome_id"
  end

  create_table "occurrence_natures", force: :cascade do |t|
    t.string "description"
    t.bigint "occurrence_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["occurrence_type_id"], name: "index_occurrence_natures_on_occurrence_type_id"
  end

  create_table "occurrence_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "occurrences", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "final_time"
    t.integer "amount"
    t.bigint "occurrence_nature_id"
    t.bigint "service_station_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_occurrences_on_event_id"
    t.index ["occurrence_nature_id"], name: "index_occurrences_on_occurrence_nature_id"
    t.index ["service_station_id"], name: "index_occurrences_on_service_station_id"
  end

  create_table "permissions", id: false, force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "app_module_id"
    t.json "actions"
    t.index ["app_module_id"], name: "index_permissions_on_app_module_id"
    t.index ["profile_id", "app_module_id"], name: "index_permissions_on_profile_id_and_app_module_id", unique: true
    t.index ["profile_id"], name: "index_permissions_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_station_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_station_vehicle_types", force: :cascade do |t|
    t.bigint "service_station_id"
    t.bigint "vehicle_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_station_id"], name: "index_service_station_vehicle_types_on_service_station_id"
    t.index ["vehicle_type_id"], name: "index_service_station_vehicle_types_on_vehicle_type_id"
  end

  create_table "service_station_work_shifts", force: :cascade do |t|
    t.bigint "service_station_id"
    t.integer "work_shift"
    t.integer "militaries_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_station_id"], name: "index_service_station_work_shifts_on_service_station_id"
  end

  create_table "service_stations", force: :cascade do |t|
    t.string "description"
    t.string "acronym"
    t.bigint "event_id"
    t.bigint "command_post_id"
    t.bigint "service_station_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["command_post_id"], name: "index_service_stations_on_command_post_id"
    t.index ["event_id"], name: "index_service_stations_on_event_id"
    t.index ["service_station_type_id"], name: "index_service_stations_on_service_station_type_id"
  end

  create_table "technical_service_intervals", force: :cascade do |t|
    t.string "description"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "technical_service_occurrences", force: :cascade do |t|
    t.bigint "technical_service_id"
    t.bigint "occurrence_nature_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["occurrence_nature_id"], name: "index_technical_service_occurrences_on_occurrence_nature_id"
    t.index ["technical_service_id"], name: "index_technical_service_occurrences_on_technical_service_id"
  end

  create_table "technical_services", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "final_time"
    t.bigint "sgp_military_id", null: false
    t.bigint "technical_service_interval_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sgp_military_id"], name: "index_technical_services_on_sgp_military_id"
    t.index ["technical_service_interval_id"], name: "index_technical_services_on_technical_service_interval_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["profile_id"], name: "index_users_on_profile_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicle_types", force: :cascade do |t|
    t.string "description"
    t.string "acronym"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "about"
  end

  add_foreign_key "occurrence_natures", "occurrence_types"
  add_foreign_key "occurrences", "events"
  add_foreign_key "occurrences", "occurrence_natures"
  add_foreign_key "occurrences", "service_stations"
  add_foreign_key "permissions", "app_modules"
  add_foreign_key "permissions", "profiles"
  add_foreign_key "service_station_vehicle_types", "service_stations"
  add_foreign_key "service_station_vehicle_types", "vehicle_types"
  add_foreign_key "service_station_work_shifts", "service_stations"
  add_foreign_key "service_stations", "command_posts"
  add_foreign_key "service_stations", "events"
  add_foreign_key "service_stations", "service_station_types"
  add_foreign_key "technical_service_occurrences", "occurrence_natures"
  add_foreign_key "technical_service_occurrences", "technical_services"
  add_foreign_key "technical_services", "technical_service_intervals"
  add_foreign_key "users", "profiles"
end
