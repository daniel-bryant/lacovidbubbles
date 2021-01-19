# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_19_193439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "data", force: :cascade do |t|
    t.bigint "parse_id", null: false
    t.string "obs", null: false
    t.string "name", null: false
    t.string "address", null: false
    t.integer "total_staff", null: false
    t.integer "total_non_staff", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.index ["parse_id"], name: "index_data_on_parse_id"
  end

  create_table "parses", force: :cascade do |t|
    t.string "type", null: false
    t.boolean "complete", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["type", "complete"], name: "index_parses_on_type_and_complete"
  end

  add_foreign_key "data", "parses"
end
