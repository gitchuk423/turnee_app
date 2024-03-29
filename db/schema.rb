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

ActiveRecord::Schema.define(:version => 20120621032021) do

  create_table "activities", :force => true do |t|
    t.boolean  "public"
    t.integer  "item_id"
    t.integer  "person_id"
    t.string   "item_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "activities", ["item_id"], :name => "index_activities_on_item_id"
  add_index "activities", ["item_type"], :name => "index_activities_on_item_type"

  create_table "attorneys", :force => true do |t|
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "email"
    t.string   "remember_token"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
    t.boolean  "admin",           :default => false
    t.string   "country"
    t.string   "state"
    t.string   "attorney_type"
    t.string   "city"
  end

  add_index "attorneys", ["email"], :name => "index_attorneys_on_email"
  add_index "attorneys", ["remember_token"], :name => "index_attorneys_on_remember_token"

  create_table "clients", :force => true do |t|
    t.integer  "referral_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
  end

  create_table "connections", :force => true do |t|
    t.integer  "attorney_id"
    t.integer  "contact_id"
    t.integer  "status"
    t.datetime "accepted_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "connections", ["attorney_id", "contact_id"], :name => "index_connections_on_person_id_and_contact_id"

  create_table "feeds", :force => true do |t|
    t.integer "person_id"
    t.integer "activity_id"
  end

  add_index "feeds", ["person_id", "activity_id"], :name => "index_feeds_on_person_id_and_activity_id"

  create_table "personal_records", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "attorney_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "personal_records", ["email"], :name => "index_personal_records_on_email", :unique => true

  create_table "professional_experiences", :force => true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "attorney_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "position"
    t.boolean  "current",     :default => false
    t.string   "city"
    t.string   "state"
    t.string   "country"
  end

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
    t.integer  "attorney_id"
    t.integer  "referred_to_attorney_id"
    t.integer  "client_id"
    t.text     "public_comments"
    t.text     "private_comments"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "referral_name"
    t.string   "status"
    t.string   "client_first_name"
    t.string   "client_last_name"
    t.string   "client_email"
    t.string   "client_phone"
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
