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

ActiveRecord::Schema.define(version: 20141216160834) do

  create_table "branches", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "repo_id"
  end

  add_index "branches", ["repo_id"], name: "index_branches_on_repo_id", using: :btree

  create_table "examples", force: true do |t|
    t.text     "description"
    t.text     "filename"
    t.integer  "line_number"
    t.string   "status"
    t.integer  "test_run_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "examples", ["test_run_id"], name: "index_examples_on_test_run_id", using: :btree

  create_table "github_accounts", force: true do |t|
    t.string   "name"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
  end

  create_table "repos", force: true do |t|
    t.string   "name"
    t.integer  "github_account_id"
    t.string   "github_name"
    t.datetime "last_synced"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repos", ["github_account_id"], name: "index_repos_on_github_account_id", using: :btree

  create_table "test_runs", force: true do |t|
    t.integer  "branch_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "test_runs", ["branch_id"], name: "index_test_runs_on_branch_id", using: :btree

end
