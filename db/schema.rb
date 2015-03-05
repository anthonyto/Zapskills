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

ActiveRecord::Schema.define(version: 20150305151138) do

  create_table "experiences", force: :cascade do |t|
    t.integer "user_id",     limit: 4
    t.integer "skill_id",    limit: 4
    t.date    "start_date"
    t.text    "description", limit: 65535
    t.integer "level",       limit: 4
  end

  add_index "experiences", ["skill_id"], name: "index_experiences_on_skill_id", using: :btree
  add_index "experiences", ["user_id"], name: "index_experiences_on_user_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",          limit: 255
    t.string   "last_name",           limit: 255
    t.string   "email",               limit: 255
    t.string   "city",                limit: 255
    t.string   "state",               limit: 255
    t.string   "zip_code",            limit: 255
    t.date     "date_of_birth"
    t.string   "password",            limit: 255
    t.string   "profile_picture_url", limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
