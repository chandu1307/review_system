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

ActiveRecord::Schema.define(version: 20170503064534) do

  create_table "goals", force: :cascade do |t|
    t.text     "description"
    t.integer  "weightage"
    t.integer  "review_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["review_id"], name: "index_goals_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "name"
    t.integer  "user_id"
    t.boolean  "submitted"
    t.boolean  "approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "avatar_url"
    t.boolean  "manager"
    t.boolean  "admin"
    t.integer  "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
