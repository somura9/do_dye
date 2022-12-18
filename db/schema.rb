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

ActiveRecord::Schema[7.0].define(version: 2022_12_17_110335) do
  create_table "embeds", charset: "utf8mb4", force: :cascade do |t|
    t.string "embed_type"
    t.string "identifier"
    t.bigint "tab_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tab_id"], name: "index_embeds_on_tab_id"
  end

  create_table "likes", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "work_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_likes_on_user_id"
    t.index ["work_id"], name: "index_likes_on_work_id"
  end

  create_table "media", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "tab_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tab_id"], name: "index_media_on_tab_id"
  end

  create_table "sentences", charset: "utf8mb4", force: :cascade do |t|
    t.text "body"
    t.bigint "tab_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tab_id"], name: "index_sentences_on_tab_id"
  end

  create_table "tabs", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "work_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_id"], name: "index_tabs_on_work_id"
  end

  create_table "tags", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "avatar"
    t.string "bio"
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "work_blocks", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.string "blockable_type", null: false
    t.bigint "blockable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blockable_type", "blockable_id"], name: "index_work_blocks_on_blockable"
    t.index ["work_id"], name: "index_work_blocks_on_work_id"
  end

  create_table "work_tags", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_work_tags_on_tag_id"
    t.index ["work_id"], name: "index_work_tags_on_work_id"
  end

  create_table "works", charset: "utf8mb4", force: :cascade do |t|
    t.string "title", null: false
    t.string "thumbnail"
    t.string "summary"
    t.integer "status"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_works_on_user_id"
  end

  add_foreign_key "embeds", "tabs"
  add_foreign_key "likes", "users"
  add_foreign_key "likes", "works"
  add_foreign_key "media", "tabs"
  add_foreign_key "sentences", "tabs"
  add_foreign_key "tabs", "works"
  add_foreign_key "work_blocks", "works"
  add_foreign_key "work_tags", "tags"
  add_foreign_key "work_tags", "works"
  add_foreign_key "works", "users"
end