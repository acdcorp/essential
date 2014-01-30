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

ActiveRecord::Schema.define(version: 20140130003933) do

  create_table "abilities", force: true do |t|
    t.string   "name",        limit: 50,       null: false
    t.string   "conditions"
    t.string   "fields"
    t.text     "description", limit: 16777215
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "addresses", force: true do |t|
    t.string   "line1",         limit: 100, null: false
    t.string   "line2",         limit: 100
    t.string   "city",          limit: 100
    t.string   "state",         limit: 2,   null: false
    t.string   "zip",           limit: 5,   null: false
    t.integer  "location_id",               null: false
    t.string   "location_type",             null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "addresses", ["location_type", "location_id"], name: "index_addresses_on_location_type_and_location_id", using: :btree

  create_table "carrier_adjusters", force: true do |t|
    t.string   "first_name",         limit: 50, null: false
    t.string   "last_name",          limit: 50, null: false
    t.string   "business_phone"
    t.string   "string"
    t.string   "business_phone_ext"
    t.integer  "carrier_office_id",             null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "carrier_adjusters", ["carrier_office_id"], name: "carrier_adjusters_carrier_office_id_fk", using: :btree

  create_table "carrier_offices", force: true do |t|
    t.string   "name",         limit: 50, null: false
    t.string   "phone_number"
    t.integer  "carrier_id",              null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "carrier_offices", ["carrier_id"], name: "carrier_offices_carrier_id_fk", using: :btree

  create_table "carriers", force: true do |t|
    t.string   "name",       limit: 50, null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "claim_files", force: true do |t|
    t.integer  "claim_id",                 null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "local"
    t.string   "name",         limit: 50,  null: false
    t.string   "extension",    limit: 10,  null: false
    t.string   "size",         limit: 20,  null: false
    t.string   "type",         limit: 100, null: false
    t.integer  "savable_id"
    t.string   "savable_type"
    t.string   "s3",           limit: 100
  end

  add_index "claim_files", ["claim_id"], name: "index_claim_files_on_claim_id", using: :btree
  add_index "claim_files", ["created_at"], name: "index_claim_files_on_created_at", using: :btree
  add_index "claim_files", ["creator_id"], name: "index_claim_files_on_creator_id", using: :btree
  add_index "claim_files", ["deleted_at"], name: "index_claim_files_on_deleted_at", using: :btree

  create_table "claim_notes", force: true do |t|
    t.integer  "claim_id",                                              null: false
    t.text     "comment",             limit: 16777215,                  null: false
    t.string   "permission",          limit: 50,                        null: false
    t.integer  "record_id"
    t.string   "record_type"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.datetime "alert_at"
    t.integer  "alert_repeat_number"
    t.string   "alert_repeat_type",   limit: 50
    t.datetime "alert_deleted_at"
    t.string   "type",                limit: 50,       default: "user", null: false
    t.boolean  "alert_disabled",                       default: false,  null: false
  end

  add_index "claim_notes", ["claim_id"], name: "notes_claim_id_fk", using: :btree
  add_index "claim_notes", ["created_at"], name: "index_claim_notes_on_created_at", using: :btree
  add_index "claim_notes", ["creator_id"], name: "index_claim_notes_on_creator_id", using: :btree
  add_index "claim_notes", ["deleted_at"], name: "index_claim_notes_on_deleted_at", using: :btree

  create_table "claim_users", force: true do |t|
    t.integer  "claim_id",   null: false
    t.integer  "user_id",    null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "role"
  end

  add_index "claim_users", ["claim_id"], name: "index_claim_users_on_claim_id", using: :btree
  add_index "claim_users", ["role"], name: "index_claim_users_on_role", using: :btree
  add_index "claim_users", ["user_id"], name: "index_claim_users_on_user_id", using: :btree

  create_table "claims", force: true do |t|
    t.integer  "company_id",                                                                             null: false
    t.integer  "carrier_id",                                                                             null: false
    t.string   "status",                     limit: 50,                                                  null: false
    t.string   "review_type",                limit: 50,                                                  null: false
    t.string   "appraisal_author",           limit: 50,                                                  null: false
    t.string   "type_of_loss",               limit: 50,                                                  null: false
    t.string   "number",                     limit: 50,                                                  null: false
    t.string   "point_of_impact",            limit: 100,                                                 null: false
    t.decimal  "deductible",                                  precision: 10, scale: 2,                   null: false
    t.datetime "estimate_written_on",                                                                    null: false
    t.boolean  "is_inactive",                                                          default: false,   null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                                                             null: false
    t.datetime "updated_at",                                                                             null: false
    t.boolean  "is_flagged",                                                           default: false
    t.string   "acd_number"
    t.integer  "primary_client_contact_id"
    t.integer  "subrogator_id"
    t.datetime "reviewed_at"
    t.text     "supplement_reason",          limit: 16777215
    t.integer  "carrier_office_id"
    t.integer  "carrier_office_adjuster_id"
    t.boolean  "won"
    t.boolean  "split"
    t.string   "carrier_number",                                                                         null: false
    t.boolean  "is_total_loss",                                                        default: false,   null: false
    t.string   "request_type",               limit: 50,                                default: "audit"
    t.string   "suffix",                     limit: 10
    t.boolean  "is_closed",                                                            default: false,   null: false
    t.datetime "closed_at"
    t.boolean  "is_acd_negotiation",                                                   default: false
    t.integer  "active_supplement_id"
  end

  add_index "claims", ["carrier_id"], name: "index_claims_on_carrier_id", using: :btree
  add_index "claims", ["company_id"], name: "index_claims_on_company_id", using: :btree
  add_index "claims", ["created_at"], name: "index_claims_on_created_at", using: :btree
  add_index "claims", ["status"], name: "index_claims_on_status", using: :btree

  create_table "claims_labels", force: true do |t|
    t.integer  "claim_id"
    t.integer  "label_id"
    t.integer  "company_id"
    t.string   "reason"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "claims_labels", ["claim_id"], name: "index_claims_labels_on_claim_id", using: :btree
  add_index "claims_labels", ["company_id"], name: "index_claims_labels_on_company_id", using: :btree
  add_index "claims_labels", ["label_id"], name: "index_claims_labels_on_label_id", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name",           null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "api_company_id"
  end

  create_table "company_settings", force: true do |t|
    t.decimal  "audit_fee",                                     precision: 6, scale: 2
    t.integer  "company_id",                                                                                    null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                                                                    null: false
    t.datetime "updated_at",                                                                                    null: false
    t.decimal  "supplement_fee",                                precision: 8, scale: 2
    t.string   "billing_interval"
    t.boolean  "email_primary_client_contact",                                          default: true
    t.text     "claim_emails",                 limit: 16777215
    t.boolean  "is_default_negotiator",                                                 default: false
    t.text     "invoice_emails"
    t.boolean  "email_claim",                                                           default: false,         null: false
    t.boolean  "email_claim_with_invoice",                                              default: false,         null: false
    t.boolean  "email_invoice_separately",                                              default: false,         null: false
    t.string   "pdf_template_type",            limit: 50,                               default: "acd_default"
    t.string   "email_type",                   limit: 50,                               default: "one_pdf"
    t.text     "excess_claim_emails"
    t.integer  "excess_alert_repeat_number"
    t.string   "excess_alert_repeat_type",     limit: 50
    t.decimal  "excess_fee",                                    precision: 6, scale: 2
    t.decimal  "total_loss_fee",                                precision: 6, scale: 2, default: 0.0
    t.decimal  "negotiation_fee",                               precision: 6, scale: 2, default: 0.0
  end

  add_index "company_settings", ["company_id"], name: "index_company_settings_on_company_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",                    default: 0
    t.integer  "attempts",                    default: 0
    t.text     "handler",    limit: 16777215
    t.text     "last_error", limit: 16777215
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "email_logs", force: true do |t|
    t.string   "from"
    t.string   "to"
    t.string   "subject"
    t.string   "type"
    t.integer  "emailable_id"
    t.string   "emailable_type"
    t.datetime "sent_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "invoices", force: true do |t|
    t.decimal  "base_fee",                         precision: 8,  scale: 2, default: 0.0
    t.text     "notes",           limit: 16777215
    t.integer  "claim_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
    t.string   "type"
    t.decimal  "total_loss_fee",                   precision: 6,  scale: 2, default: 0.0
    t.decimal  "negotiation_fee",                  precision: 6,  scale: 2, default: 0.0
    t.decimal  "additional_fee",                   precision: 6,  scale: 2, default: 0.0
    t.decimal  "excess_fee",                       precision: 8,  scale: 2, default: 0.0
    t.decimal  "supplement_fee",                   precision: 8,  scale: 2, default: 0.0
    t.decimal  "audit_fee",                        precision: 8,  scale: 2, default: 0.0
    t.decimal  "total_fee",                        precision: 10, scale: 2, default: 0.0
    t.boolean  "is_paid",                                                   default: false
    t.datetime "locked_at"
    t.integer  "supplement_id"
  end

  add_index "invoices", ["claim_id"], name: "index_invoices_on_claim_id", using: :btree

  create_table "labels", force: true do |t|
    t.string   "name",                               null: false
    t.string   "hex",                                null: false
    t.string   "description"
    t.integer  "company_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "type",        limit: 50
    t.integer  "importance",             default: 0, null: false
  end

  add_index "labels", ["company_id"], name: "index_labels_on_company_id", using: :btree
  add_index "labels", ["name"], name: "index_labels_on_name", using: :btree

  create_table "line_items", force: true do |t|
    t.integer  "number",                                                                        null: false
    t.decimal  "hours",                                precision: 6,  scale: 2,                 null: false
    t.decimal  "revised_hours",                        precision: 6,  scale: 2,                 null: false
    t.decimal  "price",                                precision: 10, scale: 2,                 null: false
    t.decimal  "revised_price",                        precision: 10, scale: 2,                 null: false
    t.decimal  "total",                                precision: 10, scale: 2,                 null: false
    t.decimal  "revised_total",                        precision: 10, scale: 2,                 null: false
    t.decimal  "total_difference",                     precision: 10, scale: 2,                 null: false
    t.boolean  "tax",                                                           default: false
    t.boolean  "revised_tax",                                                   default: false
    t.boolean  "redlined",                                                      default: false
    t.string   "operation",           limit: 50
    t.string   "revised_operation",   limit: 50
    t.string   "type",                limit: 50
    t.string   "revised_type",        limit: 50
    t.string   "labor_type",          limit: 50
    t.string   "revised_labor_type",  limit: 50
    t.string   "description",         limit: 100
    t.text     "comment",             limit: 16777215
    t.integer  "subro_id",                                                                      null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                                                    null: false
    t.datetime "updated_at",                                                                    null: false
    t.string   "revised_description"
  end

  add_index "line_items", ["deleted_at"], name: "index_line_items_on_deleted_at", using: :btree
  add_index "line_items", ["subro_id"], name: "line_items_subro_id_fk", using: :btree

  create_table "owners", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.integer  "claim_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "owners", ["claim_id"], name: "index_owners_on_claim_id", unique: true, using: :btree

  create_table "payments", force: true do |t|
    t.decimal  "fee",                         precision: 8, scale: 2
    t.text     "note",       limit: 16777215
    t.integer  "claim_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "payments", ["claim_id"], name: "index_payments_on_claim_id", using: :btree

  create_table "permissions", force: true do |t|
    t.integer  "record_id",   null: false
    t.string   "record_type", null: false
    t.integer  "ability_id",  null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "permissions", ["ability_id"], name: "index_permissions_on_ability_id", using: :btree
  add_index "permissions", ["record_id"], name: "index_permissions_on_record_id", using: :btree
  add_index "permissions", ["record_type"], name: "index_permissions_on_record_type", using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message",    limit: 16777215
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name",        limit: 50,       default: "", null: false
    t.text     "description", limit: 16777215
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id",                  null: false
    t.text     "data",       limit: 16777215
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "subro_reports", force: true do |t|
    t.decimal  "total_original_demand_amount",   precision: 65, scale: 2, default: 0.0
    t.decimal  "total_original_labor_cost",      precision: 65, scale: 2, default: 0.0
    t.decimal  "total_original_oem",             precision: 65, scale: 2, default: 0.0
    t.decimal  "total_original_aftermarket",     precision: 65, scale: 2, default: 0.0
    t.decimal  "total_original_recycled",        precision: 65, scale: 2, default: 0.0
    t.decimal  "total_original_towing",          precision: 65, scale: 2, default: 0.0
    t.decimal  "total_original_rental",          precision: 65, scale: 2, default: 0.0
    t.decimal  "total_original_storage",         precision: 65, scale: 2, default: 0.0
    t.decimal  "total_original_misc",            precision: 65, scale: 2, default: 0.0
    t.decimal  "total_revised_demand_amount",    precision: 65, scale: 2, default: 0.0
    t.decimal  "total_revised_labor_cost",       precision: 65, scale: 2, default: 0.0
    t.decimal  "total_revised_oem",              precision: 65, scale: 2, default: 0.0
    t.decimal  "total_revised_aftermarket",      precision: 65, scale: 2, default: 0.0
    t.decimal  "total_revised_recycled",         precision: 65, scale: 2, default: 0.0
    t.decimal  "total_revised_towing",           precision: 65, scale: 2, default: 0.0
    t.decimal  "total_revised_rental",           precision: 65, scale: 2, default: 0.0
    t.decimal  "total_revised_storage",          precision: 65, scale: 2, default: 0.0
    t.decimal  "total_revised_misc",             precision: 65, scale: 2, default: 0.0
    t.decimal  "total_settled_demand_amount",    precision: 65, scale: 2, default: 0.0
    t.decimal  "total_settled_labor_cost",       precision: 65, scale: 2, default: 0.0
    t.decimal  "total_settled_oem",              precision: 65, scale: 2, default: 0.0
    t.decimal  "total_settled_aftermarket",      precision: 65, scale: 2, default: 0.0
    t.decimal  "total_settled_recycled",         precision: 65, scale: 2, default: 0.0
    t.decimal  "total_settled_towing",           precision: 65, scale: 2, default: 0.0
    t.decimal  "total_settled_rental",           precision: 65, scale: 2, default: 0.0
    t.decimal  "total_settled_storage",          precision: 65, scale: 2, default: 0.0
    t.decimal  "total_settled_misc",             precision: 65, scale: 2, default: 0.0
    t.integer  "total_won",                                               default: 0
    t.integer  "total_split",                                             default: 0
    t.integer  "total_loss",                                              default: 0
    t.integer  "total_subros",                                            default: 0
    t.integer  "total_line_items",                                        default: 0
    t.string   "report_interval"
    t.string   "status"
    t.integer  "company_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.integer  "claim_id"
    t.decimal  "total_original_estimate_amount", precision: 65, scale: 2, default: 0.0
    t.decimal  "total_revised_estimate_amount",  precision: 65, scale: 2, default: 0.0
    t.decimal  "total_settled_estimate_amount",  precision: 65, scale: 2, default: 0.0
  end

  add_index "subro_reports", ["claim_id"], name: "index_subro_reports_on_claim_id", using: :btree
  add_index "subro_reports", ["company_id"], name: "subro_reports_company_id_fk", using: :btree

  create_table "subros", force: true do |t|
    t.decimal  "body_labor_rate",                            precision: 6,  scale: 2,               null: false
    t.decimal  "mechanical_labor_rate",                      precision: 6,  scale: 2,               null: false
    t.decimal  "frame_labor_rate",                           precision: 6,  scale: 2,               null: false
    t.decimal  "refinish_labor_rate",                        precision: 6,  scale: 2,               null: false
    t.decimal  "materials_labor_rate",                       precision: 6,  scale: 2,               null: false
    t.decimal  "original_demand_amount",                     precision: 8,  scale: 2,               null: false
    t.decimal  "original_labor_cost",                        precision: 8,  scale: 2,               null: false
    t.decimal  "original_oem",                               precision: 8,  scale: 2,               null: false
    t.decimal  "original_aftermarket",                       precision: 8,  scale: 2,               null: false
    t.decimal  "original_recycled",                          precision: 8,  scale: 2,               null: false
    t.decimal  "original_rental",                            precision: 8,  scale: 2,               null: false
    t.decimal  "original_storage",                           precision: 8,  scale: 2,               null: false
    t.decimal  "original_towing",                            precision: 8,  scale: 2,               null: false
    t.decimal  "settled_labor_cost",                         precision: 8,  scale: 2
    t.decimal  "settled_oem",                                precision: 8,  scale: 2
    t.decimal  "settled_aftermarket",                        precision: 8,  scale: 2
    t.decimal  "settled_recycled",                           precision: 8,  scale: 2
    t.decimal  "settled_rental",                             precision: 8,  scale: 2
    t.decimal  "settled_storage",                            precision: 8,  scale: 2
    t.decimal  "settled_towing",                             precision: 8,  scale: 2
    t.decimal  "settled_demand_amount",                      precision: 8,  scale: 2
    t.decimal  "tax_rate",                                   precision: 8,  scale: 2,               null: false
    t.decimal  "revised_total",                              precision: 10, scale: 2,               null: false
    t.text     "review_summary",            limit: 16777215
    t.integer  "claim_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                                                                        null: false
    t.datetime "updated_at",                                                                        null: false
    t.decimal  "original_total",                             precision: 10, scale: 2
    t.decimal  "revised_demand_amount",                      precision: 10, scale: 2
    t.decimal  "misc_labor_rate",                            precision: 6,  scale: 2, default: 0.0, null: false
    t.decimal  "revised_labor_cost",                         precision: 8,  scale: 2, default: 0.0
    t.decimal  "revised_oem",                                precision: 8,  scale: 2, default: 0.0
    t.decimal  "revised_aftermarket",                        precision: 8,  scale: 2, default: 0.0
    t.decimal  "revised_recycled",                           precision: 8,  scale: 2, default: 0.0
    t.decimal  "revised_rental",                             precision: 8,  scale: 2, default: 0.0
    t.decimal  "revised_storage",                            precision: 8,  scale: 2, default: 0.0
    t.decimal  "revised_towing",                             precision: 8,  scale: 2, default: 0.0
    t.decimal  "original_misc",                              precision: 6,  scale: 2,               null: false
    t.decimal  "revised_misc",                               precision: 6,  scale: 2,               null: false
    t.decimal  "settled_misc",                               precision: 6,  scale: 2
    t.integer  "total_line_numbers"
    t.decimal  "original_estimate_amount",                   precision: 8,  scale: 2, default: 0.0
    t.decimal  "revised_estimate_amount",                    precision: 8,  scale: 2, default: 0.0
    t.decimal  "settled_estimate_amount",                    precision: 8,  scale: 2, default: 0.0
    t.decimal  "liability",                                  precision: 8,  scale: 2
    t.decimal  "out_of_pocket",                              precision: 8,  scale: 2
    t.decimal  "original_vehicle_acv",                       precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "original_taxes",                             precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "original_fees",                              precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "original_deducted_salvage",                  precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "revised_vehicle_acv",                        precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "revised_taxes",                              precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "revised_fees",                               precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "revised_deducted_salvage",                   precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "settled_vehicle_acv",                        precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "settled_taxes",                              precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "settled_fees",                               precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "settled_deducted_salvage",                   precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "original_parts_amount",                      precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "revised_parts_amount",                       precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "settled_parts_amount",                       precision: 10, scale: 2, default: 0.0, null: false
  end

  add_index "subros", ["claim_id"], name: "index_subros_on_claim_id", unique: true, using: :btree

  create_table "supplements", force: true do |t|
    t.decimal  "original_body_labor_rate",            precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_mechanical_labor_rate",      precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_frame_labor_rate",           precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_refinish_labor_rate",        precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_materials_labor_rate",       precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_liability",                  precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_out_of_pocket",              precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_tax_rate",                   precision: 4,  scale: 2, default: 0.0
    t.decimal  "original_demand_amount",              precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_estimate_amount",            precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_oem",                        precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_aftermarket",                precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_recycled",                   precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_rental",                     precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_storage",                    precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_towing",                     precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_estimate_amount",             precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_oem",                         precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_aftermarket",                 precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_recycled",                    precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_rental",                      precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_storage",                     precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_towing",                      precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_demand_amount",               precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_misc",                       precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_misc",                        precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_deducted_salvage",           precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_deducted_salvage",            precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_vehicle_acv",                precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_taxes",                      precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_fees",                       precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_vehicle_acv",                 precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_taxes",                       precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "revised_fees",                        precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "original_total",                      precision: 10, scale: 2, default: 0.0
    t.decimal  "revised_total",                       precision: 10, scale: 2, default: 0.0
    t.decimal  "supp_original_body_labor_rate",       precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_mechanical_labor_rate", precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_frame_labor_rate",      precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_refinish_labor_rate",   precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_materials_labor_rate",  precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_liability",             precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_out_of_pocket",         precision: 6,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_tax_rate",              precision: 4,  scale: 2, default: 0.0
    t.decimal  "supp_original_demand_amount",         precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_estimate_amount",       precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_oem",                   precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_aftermarket",           precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_recycled",              precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_rental",                precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_storage",               precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_towing",                precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_estimate_amount",        precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_oem",                    precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_aftermarket",            precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_recycled",               precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_rental",                 precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_storage",                precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_towing",                 precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_demand_amount",          precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_difference_total",               precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_misc",                  precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_misc",                   precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_deducted_salvage",      precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_deducted_salvage",       precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_vehicle_acv",           precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_taxes",                 precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_fees",                  precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_vehicle_acv",            precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_taxes",                  precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_revised_fees",                   precision: 8,  scale: 2, default: 0.0,   null: false
    t.decimal  "supp_original_total",                 precision: 10, scale: 2, default: 0.0
    t.decimal  "supp_revised_total",                  precision: 10, scale: 2, default: 0.0
    t.boolean  "is_completed",                                                 default: false, null: false
    t.integer  "claim_id"
    t.datetime "completed_at"
    t.datetime "created_at",                                                                   null: false
    t.datetime "updated_at",                                                                   null: false
    t.text     "reason"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "user_settings", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id",                   null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "active_claims", default: 0
  end

  add_index "user_settings", ["user_id"], name: "index_user_settings_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "cell_phone"
    t.string   "business_phone_ext"
    t.string   "business_phone"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "creator_id",                          null: false
    t.integer  "updater_id",                          null: false
    t.integer  "role_id",                             null: false
    t.integer  "company_id",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vehicles", force: true do |t|
    t.integer  "year",                  null: false
    t.string   "make",       limit: 50, null: false
    t.string   "model",      limit: 50, null: false
    t.string   "vin",        limit: 17, null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "claim_id"
    t.string   "model_name"
  end

  add_index "vehicles", ["claim_id"], name: "claim_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",                       null: false
    t.integer  "item_id",                         null: false
    t.string   "event",                           null: false
    t.integer  "claim_id"
    t.string   "whodunnit"
    t.text     "object",         limit: 16777215
    t.datetime "created_at"
    t.text     "object_changes", limit: 16777215
  end

  add_index "versions", ["item_type", "item_id", "claim_id"], name: "index_versions_on_item_type_and_item_id_and_claim_id", using: :btree

end
