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

ActiveRecord::Schema.define(:version => 20120603231208) do

  create_table "attorneys", :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
  end

  create_table "clients", :force => true do |t|
    t.integer  "attorney_id"
    t.integer  "personal_record_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "personal_records", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "attorney_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "personal_records", ["email"], :name => "index_personal_records_on_email", :unique => true

  create_table "professional_records", :force => true do |t|
    t.string   "experience"
    t.string   "firm_name"
    t.integer  "attorney_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "publications", :force => true do |t|
    t.string   "name"
    t.datetime "publication_date"
    t.string   "url"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "professional_record_id"
  end

  create_table "referrals", :force => true do |t|
    t.integer  "referred_from_attorney_id"
    t.integer  "referred_to_attorney_id"
    t.integer  "status"
    t.integer  "client_id"
    t.text     "public_comments"
    t.text     "private_comments"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "major"
    t.integer  "attorney_id"
    t.integer  "professional_record_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

end
