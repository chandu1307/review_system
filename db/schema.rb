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

ActiveRecord::Schema.define(version: 20200328064215) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feedbacks", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goals", force: :cascade do |t|
    t.text "description"
    t.bigint "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "manager_feedback", limit: 255
    t.index ["review_id"], name: "idx_34335_index_goals_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "mode"
    t.bigint "feedback_user_id"
    t.index ["user_id"], name: "idx_34344_index_reviews_on_user_id"
  end

  create_table "self_ratings", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "goal_id"
    t.bigint "rating"
    t.bigint "total_rating"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "email", limit: 255
    t.string "avatar_url", limit: 255
    t.boolean "manager"
    t.boolean "admin"
    t.bigint "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
  end

  add_foreign_key "goals", "reviews", on_update: :restrict, on_delete: :restrict
  add_foreign_key "reviews", "users", on_update: :restrict, on_delete: :restrict
end
