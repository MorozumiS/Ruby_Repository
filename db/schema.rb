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

ActiveRecord::Schema.define(version: 2023_11_09_044929) do

  create_table "lost_item_images", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "content", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "lost_item_id"
    t.index ["lost_item_id"], name: "index_lost_item_images_on_lost_item_id"
  end

  create_table "lost_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "place", null: false
    t.string "comment"
    t.string "owner_name"
    t.string "owner_tel"
    t.string "owner_address"
    t.string "features"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "lost_storage_id"
    t.bigint "project_id"
    t.index ["lost_storage_id"], name: "index_lost_items_on_lost_storage_id"
    t.index ["project_id"], name: "index_lost_items_on_project_id"
  end

  create_table "lost_people", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "kana", null: false
    t.integer "gender", null: false
    t.string "age", null: false
    t.string "tall", null: false
    t.integer "status", null: false
    t.datetime "reception_at"
    t.datetime "last_sign_in_at"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "lost_storage_id"
    t.bigint "project_id"
    t.index ["lost_storage_id"], name: "index_lost_people_on_lost_storage_id"
    t.index ["project_id"], name: "index_lost_people_on_project_id"
  end

  create_table "lost_person_images", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "content", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "lost_person_id"
    t.index ["lost_person_id"], name: "index_lost_person_images_on_lost_person_id"
  end

  create_table "lost_storages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "reception_number_prefix", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "project_id"
    t.index ["project_id"], name: "index_lost_storages_on_project_id"
  end

  create_table "projects", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "place", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.boolean "delete_flg", default: false, null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "kana", null: false
    t.string "email", null: false
    t.integer "role", null: false
    t.string "tel", null: false
    t.string "password", null: false
    t.string "password_confirmation", null: false
    t.string "uid", default: "", null: false
    t.datetime "discarded_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "lost_item_images", "lost_items"
  add_foreign_key "lost_items", "lost_storages"
  add_foreign_key "lost_items", "projects"
  add_foreign_key "lost_people", "lost_storages"
  add_foreign_key "lost_people", "projects"
  add_foreign_key "lost_person_images", "lost_people"
  add_foreign_key "lost_storages", "projects"
  add_foreign_key "projects", "users"
end
