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

ActiveRecord::Schema.define(version: 20150605170421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "title"
    t.datetime "release_date"
    t.integer  "tracks"
    t.string   "album_num"
    t.string   "image_url"
    t.string   "types",           default: [], array: true
    t.string   "large_image_url"
    t.text     "album_review"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "track_id"
    t.text     "annotation"
    t.datetime "created_at"
    t.integer  "verse"
  end

  create_table "tracks", force: :cascade do |t|
    t.string  "title"
    t.string  "track_id"
    t.integer "album_id"
    t.text    "lyrics"
    t.text    "verses",   default: [], array: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "nickname"
    t.datetime "created_at"
    t.string   "user_token"
    t.string   "user_token_secret"
    t.string   "twitter_id"
  end

end
