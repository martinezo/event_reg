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

ActiveRecord::Schema.define(version: 20140724220424) do

  create_table "admin_users", force: true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "mail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs_courses", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.string   "schedule"
    t.string   "location"
    t.string   "content_file"
    t.decimal  "price1"
    t.decimal  "price2"
    t.decimal  "price3"
    t.string   "payment_methods"
    t.string   "target"
    t.string   "prerequisites"
    t.integer  "min_quota"
    t.integer  "max_quota"
    t.string   "instructors"
    t.string   "contact"
    t.string   "image_file1"
    t.string   "image_file2"
    t.string   "image_file3"
    t.date     "start_date_pub"
    t.date     "end_date_pub"
    t.date     "start_date_reg"
    t.date     "end_date_reg"
    t.string   "mail_notif_deposit"
    t.boolean  "academic_data_required"
    t.string   "info_after_reg"
    t.string   "color_theme1"
    t.string   "color_theme2"
    t.string   "color_theme3"
    t.string   "opt_field"
    t.string   "opt_field_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.string   "price1_desc"
    t.string   "price2_desc"
    t.string   "price3_desc"
    t.string   "opt_text"
    t.string   "opt_str1"
    t.string   "opt_str2"
    t.string   "opt_bol1"
    t.string   "opt_bol2"
    t.string   "opt_sel"
    t.string   "opt_sel_options"
  end

  create_table "catalogs_participants", force: true do |t|
    t.integer  "course_id"
    t.string   "name"
    t.string   "surnames"
    t.string   "mail"
    t.string   "phone_numbers"
    t.string   "workplace"
    t.string   "bachelor_deg"
    t.string   "master_deg"
    t.string   "phd_deg"
    t.string   "inv_name"
    t.string   "inv_rfc"
    t.string   "inv_address"
    t.string   "inv_city"
    t.string   "inv_municipality"
    t.string   "inv_state"
    t.string   "inv_email"
    t.text     "opt_text"
    t.string   "str_op1"
    t.string   "opt_str1"
    t.string   "opt_str2"
    t.boolean  "opt_bol1"
    t.boolean  "opt_bol2"
    t.string   "opt_sel"
    t.boolean  "confirmed"
    t.integer  "price",            default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs_states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
