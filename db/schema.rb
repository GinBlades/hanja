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

ActiveRecord::Schema.define(version: 20151021192942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "character_languages", force: :cascade do |t|
    t.integer  "language_id",   null: false
    t.integer  "character_id",  null: false
    t.string   "meaning"
    t.string   "pronunciation"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "character_languages", ["character_id"], name: "index_character_languages_on_character_id", using: :btree
  add_index "character_languages", ["language_id", "character_id"], name: "index_character_languages_on_language_id_and_character_id", unique: true, using: :btree
  add_index "character_languages", ["language_id"], name: "index_character_languages_on_language_id", using: :btree

  create_table "character_quizzes", force: :cascade do |t|
    t.integer  "quiz_id"
    t.integer  "character_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "character_quizzes", ["character_id"], name: "index_character_quizzes_on_character_id", using: :btree
  add_index "character_quizzes", ["quiz_id"], name: "index_character_quizzes_on_quiz_id", using: :btree

  create_table "characters", force: :cascade do |t|
    t.string   "new",        null: false
    t.string   "old"
    t.string   "radical"
    t.integer  "strokes"
    t.string   "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "from_language_id"
    t.integer  "to_language_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "quizzes", ["from_language_id"], name: "index_quizzes_on_from_language_id", using: :btree
  add_index "quizzes", ["to_language_id"], name: "index_quizzes_on_to_language_id", using: :btree
  add_index "quizzes", ["user_id"], name: "index_quizzes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "character_languages", "characters"
  add_foreign_key "character_languages", "languages"
  add_foreign_key "character_quizzes", "characters"
  add_foreign_key "character_quizzes", "quizzes"
  add_foreign_key "quizzes", "languages", column: "from_language_id"
  add_foreign_key "quizzes", "languages", column: "to_language_id"
  add_foreign_key "quizzes", "users"
end
