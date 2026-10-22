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

ActiveRecord::Schema[8.1].define(version: 2026_10_22_070630) do
  create_table "booking_seats", force: :cascade do |t|
    t.integer "booking_id", null: false
    t.integer "show_id", null: false
    t.integer "seat_id", null: false
    t.decimal "ticket_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_booking_seats_on_booking_id"
    t.index ["seat_id"], name: "index_booking_seats_on_seat_id"
    t.index ["show_id"], name: "index_booking_seats_on_show_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "status"
    t.decimal "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "cinemas", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "genre"
    t.string "language"
    t.integer "duration"
    t.date "release_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "screens", force: :cascade do |t|
    t.integer "cinema_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cinema_id"], name: "index_screens_on_cinema_id"
  end

  create_table "seat_reservations", force: :cascade do |t|
    t.integer "show_id", null: false
    t.integer "seat_id", null: false
    t.integer "booking_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_seat_reservations_on_booking_id"
    t.index ["seat_id"], name: "index_seat_reservations_on_seat_id"
    t.index ["show_id"], name: "index_seat_reservations_on_show_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "screen_id", null: false
    t.string "row_label"
    t.integer "seat_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["screen_id"], name: "index_seats_on_screen_id"
  end

  create_table "shows", force: :cascade do |t|
    t.integer "movie_id", null: false
    t.integer "screen_id", null: false
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.decimal "ticket_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_shows_on_movie_id"
    t.index ["screen_id"], name: "index_shows_on_screen_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "booking_seats", "bookings"
  add_foreign_key "booking_seats", "seats"
  add_foreign_key "booking_seats", "shows"
  add_foreign_key "bookings", "users"
  add_foreign_key "screens", "cinemas"
  add_foreign_key "seat_reservations", "bookings"
  add_foreign_key "seat_reservations", "seats"
  add_foreign_key "seat_reservations", "shows"
  add_foreign_key "seats", "screens"
  add_foreign_key "shows", "movies"
  add_foreign_key "shows", "screens"
end
