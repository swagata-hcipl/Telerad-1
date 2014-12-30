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

ActiveRecord::Schema.define(version: 20141230072244) do

  create_table "comments", force: true do |t|
    t.integer  "study_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "gender"
    t.string   "dob"
    t.text     "address"
    t.string   "pincode"
    t.string   "ext_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studies", force: true do |t|
    t.integer  "user_id"
    t.integer  "patient_id"
    t.string   "study_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "gateway"
    t.string   "name"
    t.string   "address"
    t.string   "gateway_type"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
