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

ActiveRecord::Schema.define(version: 20150418055125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feeds", force: :cascade do |t|
    t.string   "link",        null: false
    t.string   "title"
    t.text     "description"
    t.datetime "date"
    t.integer  "resource_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "feeds", ["resource_id"], name: "index_feeds_on_resource_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.text     "text"
    t.string   "is_comment"
    t.string   "is_breakpoint"
    t.string   "created"
    t.string   "category"
    t.text     "description"
    t.string   "url"
    t.string   "html_url"
    t.string   "xml_url",       null: false
    t.string   "title"
    t.string   "version"
    t.string   "language"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "feeds", "resources"
end
