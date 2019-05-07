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

ActiveRecord::Schema.define(version: 2019_05_01_083359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "parent_id"
    t.string "name"
    t.string "slug"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((slug)::text)", name: "index_categories_on_lower_slug", unique: true
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "forums", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description"
    t.integer "topics_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((slug)::text)", name: "index_forums_on_lower_slug", unique: true
  end

  create_table "identities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid", "provider"], name: "index_identities_on_uid_and_provider", unique: true
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "mentions", id: false, force: :cascade do |t|
    t.bigint "post_id"
    t.bigint "user_id"
    t.index ["post_id"], name: "index_mentions_on_post_id"
    t.index ["user_id"], name: "index_mentions_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "type"
    t.bigint "user_id"
    t.string "record_type"
    t.bigint "record_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id"], name: "index_notifications_on_record_type_and_record_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "topic_id"
    t.bigint "user_id"
    t.integer "number"
    t.bigint "reply_to_post_id"
    t.text "body"
    t.bigint "edited_user_id"
    t.datetime "edited_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["edited_user_id"], name: "index_posts_on_edited_user_id"
    t.index ["reply_to_post_id"], name: "index_posts_on_reply_to_post_id"
    t.index ["topic_id"], name: "index_posts_on_topic_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "replies", id: false, force: :cascade do |t|
    t.bigint "from_post_id"
    t.bigint "to_post_id"
    t.index ["from_post_id"], name: "index_replies_on_from_post_id"
    t.index ["to_post_id"], name: "index_replies_on_to_post_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "topic_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_subscriptions_on_topic_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.bigint "forum_id"
    t.bigint "user_id"
    t.string "title", null: false
    t.integer "comments_count", default: 0
    t.bigint "last_comment_id"
    t.datetime "activated_at", null: false
    t.boolean "trashed", default: false
    t.bigint "edited_user_id"
    t.datetime "edited_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.integer "category_ancestor_ids", array: true
    t.index ["activated_at"], name: "index_topics_on_activated_at"
    t.index ["category_ancestor_ids"], name: "index_topics_on_category_ancestor_ids", using: :gin
    t.index ["category_id"], name: "index_topics_on_category_id"
    t.index ["forum_id"], name: "index_topics_on_forum_id"
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.boolean "email_verified", default: false
    t.string "password_digest", null: false
    t.text "bio"
    t.string "auth_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((email)::text)", name: "index_users_on_lower_email", unique: true
    t.index "lower((username)::text)", name: "index_users_on_lower_username", unique: true
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
  end

end