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

ActiveRecord::Schema.define(:version => 20130305031848) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "competition_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.text     "description",    :limit => 255
  end

  create_table "challenges", :force => true do |t|
    t.integer  "problem_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "competitions", :force => true do |t|
    t.string   "name"
    t.datetime "start"
    t.datetime "end"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "hidden"
  end

  create_table "logins", :force => true do |t|
    t.integer  "person_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "competition_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "participations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "competition_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "ip"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "problems", :force => true do |t|
    t.text     "description"
    t.integer  "points"
    t.boolean  "active"
    t.string   "flag"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "solves", :force => true do |t|
    t.integer  "user_id"
    t.integer  "problem_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "role"
    t.string   "name"
    t.text     "description"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "last_submission"
    t.datetime "locked"
    t.integer  "flood_count"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
