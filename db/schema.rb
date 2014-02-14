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

ActiveRecord::Schema.define(version: 20140214110420) do

  create_table "administrators", force: true do |t|
    t.string   "name"
    t.string   "gplus"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "caches", force: true do |t|
    t.string   "lightbox_id"
    t.text     "filelist",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "filecount"
  end

  create_table "lightboxes", force: true do |t|
    t.integer  "photographer_id"
    t.integer  "istockid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
    t.integer  "exampleimage"
  end

  add_index "lightboxes", ["photographer_id"], name: "index_lightboxes_on_photographer_id"

  create_table "markers", force: true do |t|
    t.string   "label"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "photographers", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "website"
    t.string   "phone"
    t.string   "email"
    t.string   "istock_name"
    t.integer  "istock_userid"
    t.string   "password"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "locationspecifier"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
