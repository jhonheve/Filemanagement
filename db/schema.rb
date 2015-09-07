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

ActiveRecord::Schema.define(version: 20150906154459) do

  create_table "comments", force: :cascade do |t|
    t.text     "description",     limit: 65535
    t.integer  "file_version_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "comments", ["file_version_id"], name: "index_comments_on_file_version_id", using: :btree

  create_table "file_versions", force: :cascade do |t|
    t.string   "path",              limit: 255
    t.integer  "versioned_file_id", limit: 4
    t.boolean  "isActive"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "file_versions", ["versioned_file_id"], name: "index_file_versions_on_versioned_file_id", using: :btree

  create_table "versioned_files", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.text     "content_type", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_foreign_key "comments", "file_versions"
  add_foreign_key "file_versions", "versioned_files"
end
