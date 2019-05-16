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

ActiveRecord::Schema.define(version: 2019_05_16_190440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "house_members", force: :cascade do |t|
    t.bigint "house_id", null: false
    t.bigint "member_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_house_members_on_house_id"
    t.index ["member_id", "house_id"], name: "index_house_members_on_member_id_and_house_id"
    t.index ["member_id"], name: "index_house_members_on_member_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "name"
    t.bigint "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_houses_on_owner_id"
  end

  create_table "todo_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "todo_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "todo_desc_idx"
  end

  create_table "todos", force: :cascade do |t|
    t.string "title"
    t.boolean "completed", default: false
    t.bigint "house_id"
    t.bigint "creator_id"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "expanded", default: false
    t.index ["creator_id"], name: "index_todos_on_creator_id"
    t.index ["house_id"], name: "index_todos_on_house_id"
    t.index ["parent_id"], name: "index_todos_on_parent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "group_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlist_items", force: :cascade do |t|
    t.bigint "wishlist_id", null: false
    t.bigint "creator_id", null: false
    t.string "title"
    t.string "link"
    t.decimal "cost"
    t.date "buy_by"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_wishlist_items_on_creator_id"
    t.index ["wishlist_id"], name: "index_wishlist_items_on_wishlist_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "house_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_wishlists_on_house_id"
  end

  add_foreign_key "house_members", "houses"
  add_foreign_key "house_members", "users", column: "member_id"
  add_foreign_key "houses", "users", column: "owner_id"
  add_foreign_key "todos", "todos", column: "parent_id"
  add_foreign_key "todos", "users", column: "creator_id"
  add_foreign_key "wishlist_items", "users", column: "creator_id"
  add_foreign_key "wishlist_items", "wishlists"
  add_foreign_key "wishlists", "houses"
end
