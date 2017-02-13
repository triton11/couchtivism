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

ActiveRecord::Schema.define(version: 20170212033055) do

  create_table "campaigns", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "campaigns_users", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "campaigns_users", ["campaign_id"], name: "index_campaigns_users_on_campaign_id"
  add_index "campaigns_users", ["user_id"], name: "index_campaigns_users_on_user_id"

  create_table "goals", force: :cascade do |t|
    t.integer  "campaign_id"
    t.string   "title"
    t.text     "content"
    t.integer  "points"
    t.string   "typed"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "time"
  end

  add_index "goals", ["campaign_id"], name: "index_goals_on_campaign_id"

  create_table "mods", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "email"
  end

  add_index "mods", ["campaign_id"], name: "index_mods_on_campaign_id"
  add_index "mods", ["user_id"], name: "index_mods_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_hash"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
