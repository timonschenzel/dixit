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

ActiveRecord::Schema.define(:version => 20121102215404) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "categories", :force => true do |t|
    t.string   "name",        :limit => 45
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :primary_key => "user_id", :force => true do |t|
    t.integer  "friend_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], :name => "friendships.fk_people_has_people_people2_idx"
  add_index "friendships", ["user_id", "friend_id"], :name => "sqlite_autoindex_friendships_1", :unique => true
  add_index "friendships", ["user_id"], :name => "friendships.fk_people_has_people_people1_idx"

  create_table "games", :force => true do |t|
    t.integer  "category_id",               :null => false
    t.string   "name",        :limit => 45
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["category_id"], :name => "games.fk_games_categories1_idx"

  create_table "oauth_users", :force => true do |t|
    t.string   "provider",   :limit => nil, :null => false
    t.string   "uid",        :limit => nil, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.integer  "round_id",       :null => false
    t.integer  "score"
    t.boolean  "is_storyteller"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["round_id"], :name => "participants.fk_participants_rounds1_idx"
  add_index "participants", ["user_id"], :name => "participants.fk_game_participants_people_idx"

  create_table "pictures", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "round_id",         :null => false
    t.integer  "votes"
    t.boolean  "is_start_picture"
    t.boolean  "is_final_picture"
    t.text     "flickr_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["round_id"], :name => "pictures.fk_submittedpictures_rounds1_idx"
  add_index "pictures", ["user_id"], :name => "pictures.fk_pictures_people1_idx"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "rounds", :force => true do |t|
    t.integer  "game_id",       :null => false
    t.text     "story_fragmet"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rounds", ["game_id"], :name => "rounds.fk_rounds_games1_idx"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :primary_key => "user_id", :force => true do |t|
    t.integer  "picture_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["picture_id"], :name => "votes.fk_votes_pictures1_idx"
  add_index "votes", ["user_id", "picture_id"], :name => "sqlite_autoindex_votes_1", :unique => true
  add_index "votes", ["user_id"], :name => "votes.fk_votes_users1_idx"

end
