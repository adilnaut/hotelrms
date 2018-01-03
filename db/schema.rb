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

ActiveRecord::Schema.define(version: 20171029134901) do

  create_table "applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "d_from"
    t.string   "d_to"
    t.string   "plan"
    t.integer  "num_of_beds"
    t.integer  "receptionist_ssn"
    t.integer  "Manager_ssn"
    t.integer  "Client_id"
    t.integer  "reserv_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "national_id"
    t.string   "first_n"
    t.string   "last_n"
    t.string   "payment_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "managers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "Ssn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receptionists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "Ssn"
    t.integer  "Manager_ssn"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "reservations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "Status"
    t.integer  "Manager_ssn"
    t.integer  "client_id"
    t.integer  "room_num"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "room_num"
    t.string   "plan"
    t.integer  "num_of_beds"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "workers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "Ssn"
    t.string   "First"
    t.string   "Last"
    t.integer  "Salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
