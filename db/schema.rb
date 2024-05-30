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

ActiveRecord::Schema[7.1].define(version: 2024_05_30_163113) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "account_invitations", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "invited_by_id"
    t.string "token", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.jsonb "roles", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "email"], name: "index_account_invitations_on_account_id_and_email", unique: true
    t.index ["invited_by_id"], name: "index_account_invitations_on_invited_by_id"
    t.index ["token"], name: "index_account_invitations_on_token", unique: true
  end

  create_table "account_users", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.jsonb "roles", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "user_id"], name: "index_account_users_on_account_id_and_user_id", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "owner_id"
    t.boolean "personal", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "extra_billing_info"
    t.string "domain"
    t.string "subdomain"
    t.string "billing_email"
    t.integer "account_users_count", default: 0
    t.index ["owner_id"], name: "index_accounts_on_owner_id"
  end

  create_table "action_text_embeds", force: :cascade do |t|
    t.string "url"
    t.jsonb "fields"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.integer "address_type"
    t.string "line1"
    t.string "line2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "announcements", force: :cascade do |t|
    t.string "kind"
    t.string "title"
    t.datetime "published_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token"
    t.string "name"
    t.jsonb "metadata", default: {}
    t.boolean "transient", default: false
    t.datetime "last_used_at", precision: nil
    t.datetime "expires_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_api_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_api_tokens_on_user_id"
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "claims", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "municipality_id", null: false
    t.string "status"
    t.string "claim_number"
    t.string "claim_type"
    t.string "type_of_property_loss"
    t.datetime "date_of_loss"
    t.string "police_ref_number"
    t.string "police_station_incident_reported_to"
    t.string "nature_of_incident"
    t.string "insured_property_ownership"
    t.text "description_of_incident"
    t.string "incident_location"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_property_insured_elsewhere"
    t.boolean "have_you_suffered_previous_loss"
    t.boolean "has_other_party_interest"
    t.boolean "was_property_occupied_during_damage"
    t.text "property_loss_location"
    t.datetime "declaration_accepted_at", precision: nil
    t.datetime "information_sharing_accepted_at", precision: nil
    t.string "liability_claim_type"
    t.string "public_liability_type"
    t.string "liability_owner_first_name"
    t.string "liability_owner_last_name"
    t.string "liability_owner_email_address"
    t.string "liability_owner_contact_number"
    t.text "liability_description_of_loss"
    t.string "liability_drivers_first_name"
    t.string "liability_drivers_last_name"
    t.string "liability_drivers_license_no"
    t.string "liability_drivers_license_date"
    t.string "liability_drivers_license_place"
    t.string "liability_drivers_license_status"
    t.string "liability_drivers_contact_number"
    t.string "liability_drivers_email"
    t.string "liability_drivers_physical_address"
    t.string "liability_contact_person_first_name"
    t.string "liability_contact_person_last_name"
    t.string "liability_contact_person_contact_number"
    t.string "liability_contact_person_email"
    t.string "liability_contact_person_physical_address"
    t.string "liability_assessment_contact_person_first_name"
    t.string "liability_assessment_contact_person_last_name"
    t.string "liability_assessment_contact_person_address"
    t.string "liability_assessment_contact_person_telephone_number"
    t.string "liability_vehicle_make"
    t.string "liability_vehicle_gross_vehicle_mass"
    t.string "liability_vehicle_registration_number"
    t.string "liability_vehicle_value"
    t.string "liability_vehicle_model"
    t.string "liability_vehicle_year"
    t.string "liability_vehicle_transmission_type"
    t.string "liability_vehicle_inspection_address"
    t.string "liability_property_witness_first_name"
    t.string "liability_property_witness_last_name"
    t.string "liability_property_witness_contact_number"
    t.string "liability_property_police_ref_number"
    t.string "liability_property_police_station_case_reported_to"
    t.date "liability_property_police_report_date"
    t.string "liability_property_police_officer_first_name"
    t.string "liability_property_police_officer_last_name"
    t.boolean "liability_is_claim_against_municipality"
    t.text "liability_description_of_incident"
    t.text "liability_claim_details"
    t.string "liability_personal_injury_first_name_of_injured_person"
    t.string "liability_personal_injury_last_name_of_injured_person"
    t.string "liability_personal_injury_age_of_injured_person"
    t.text "liability_personal_injury_details"
    t.string "liability_personal_injury_address_of_injured_person"
    t.string "liability_personal_injury_place_of_occurrence"
    t.date "liability_personal_injury_date_of_occurrence"
    t.string "liability_vehicle_km_completed"
    t.string "vehicle_value"
    t.string "liability_vehicle_drivable"
    t.boolean "liability_vehicle_towed"
    t.string "liability_registered_owner_physical_address"
    t.string "liability_motor_claim_registered_owner_first_name"
    t.string "liability_motor_claim_registered_owner_last_name"
    t.string "liability_motor_claim_registered_owner_email"
    t.string "liability_motor_claim_registered_owner_telephone_number"
    t.string "liability_motor_claim_registered_owner_physical_address"
    t.string "accident_and_health_claim_type"
    t.string "accident_and_health_claimant_first_name"
    t.string "accident_and_health_claimant_last_name"
    t.string "accident_and_health_claimant_id_number"
    t.string "accident_and_health_claimant_occupation"
    t.string "accident_and_health_death_claim_claimant_first_name"
    t.string "accident_and_health_death_claim_claimant_last_name"
    t.string "accident_and_health_death_claim_claimant_employee_status"
    t.string "accident_and_health_death_claim_confirmation_of_form_accuracy"
    t.text "accident_and_health_death_claim_about_claimant_occupation"
    t.date "accident_and_health_death_claim_date_of_death"
    t.string "accident_and_health_death_claim_place_of_death"
    t.string "accident_and_health_death_claim_any_factors_to_death_cause"
    t.date "accident_and_health_disability_claim_accident_date"
    t.string "accident_and_health_disability_claim_accident_place"
    t.string "accident_and_health_disability_claim_saps_and_oar_case_no"
    t.text "accident_and_health_disability_claim_description_of_accident"
    t.boolean "accident_and_health_disability_claim_is_permanently_disabled"
    t.boolean "accident_and_health_disability_claim_was_person_on_duty"
    t.string "accident_and_health_claim_attending_doctor_first_name"
    t.string "accident_and_health_claim_attending_doctor_last_name"
    t.string "accident_and_health_claim_attending_doctor_practice_number"
    t.string "accident_and_health_claim_attending_doctor_contact_number"
    t.string "accident_and_health_claim_attending_doctor_address"
    t.text "accident_and_health_ttd_claim_description_of_injuries"
    t.string "accident_and_health_death_claim_death_cause"
    t.string "vehicle_claim_type"
    t.string "vehicle_claim_police_no"
    t.string "vehicle_claim_accident_address"
    t.string "vehicle_claim_date_of_loss"
    t.string "vehicle_claim_vehicle_model"
    t.string "vehicle_claim_vehicle_manufacturer"
    t.string "vehicle_claim_vehicle_km_completed"
    t.string "vehicle_claim_vehicle_registration"
    t.string "vehicle_claim_vehicle_drivers_first_name"
    t.string "vehicle_claim_vehicle_drivers_last_name"
    t.string "vehicle_claim_vehicle_drivers_id_number"
    t.string "vehicle_claim_vehicle_drivers_occupation"
    t.string "vehicle_claim_vehicle_drivers_license_code"
    t.string "vehicle_claim_were_there_passengers"
    t.string "vehicle_claim_were_there_witnesses"
    t.text "vehicle_claim_accident_description"
    t.string "vehicle_claim_is_municipal_vehicle_damaged"
    t.string "vehicle_claim_was_driver_authorized"
    t.string "vehicle_claim_is_driver_your_employee"
    t.string "vehicle_claim_has_drivers_license_been_suspended"
    t.string "vehicle_claim_driver_physical_defects_status"
    t.string "vehicle_claim_vehicle_purposes"
    t.string "vehicle_claim_any_other_vehicle_damaged"
    t.string "vehicle_claim_was_vehicle_stolen_hijacked"
    t.string "vehicle_claim_leaser_of_financier"
    t.string "bank_details_bank_name"
    t.string "bank_details_branch_code"
    t.string "bank_details_account_holder_name"
    t.string "bank_details_account_number"
    t.bigint "user_id", null: false
    t.index ["municipality_id"], name: "index_claims_on_municipality_id"
    t.index ["user_id"], name: "index_claims_on_user_id"
  end

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "claim_id", null: false
    t.bigint "user_id", null: false
    t.text "description"
    t.boolean "is_verified"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["claim_id"], name: "index_comments_on_claim_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "connected_accounts", force: :cascade do |t|
    t.bigint "owner_id"
    t.string "provider"
    t.string "uid"
    t.string "refresh_token"
    t.datetime "expires_at", precision: nil
    t.text "auth"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "access_token"
    t.string "access_token_secret"
    t.string "owner_type"
    t.index ["owner_id", "owner_type"], name: "index_connected_accounts_on_owner_id_and_owner_type"
  end

  create_table "damaged_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "item_name"
    t.string "serial_number"
    t.string "estimated_value"
    t.uuid "claim_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["claim_id"], name: "index_damaged_items_on_claim_id"
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "inbound_webhooks", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "municipalities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_municipalities_on_account_id"
  end

  create_table "noticed_events", force: :cascade do |t|
    t.bigint "account_id"
    t.string "type"
    t.string "record_type"
    t.bigint "record_id"
    t.jsonb "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notifications_count"
    t.index ["account_id"], name: "index_noticed_events_on_account_id"
    t.index ["record_type", "record_id"], name: "index_noticed_events_on_record"
  end

  create_table "noticed_notifications", force: :cascade do |t|
    t.bigint "account_id"
    t.string "type"
    t.bigint "event_id", null: false
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.datetime "read_at", precision: nil
    t.datetime "seen_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_noticed_notifications_on_account_id"
    t.index ["event_id"], name: "index_noticed_notifications_on_event_id"
    t.index ["recipient_type", "recipient_id"], name: "index_noticed_notifications_on_recipient"
  end

  create_table "notification_tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.string "token", null: false
    t.string "platform", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notification_tokens_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type"
    t.jsonb "params"
    t.datetime "read_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "interacted_at", precision: nil
    t.index ["account_id"], name: "index_notifications_on_account_id"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient_type_and_recipient_id"
  end

  create_table "pay_charges", force: :cascade do |t|
    t.string "processor_id", null: false
    t.integer "amount", null: false
    t.integer "amount_refunded"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.jsonb "data"
    t.integer "application_fee_amount"
    t.string "currency"
    t.jsonb "metadata"
    t.integer "subscription_id"
    t.bigint "customer_id"
    t.string "stripe_account"
    t.index ["customer_id", "processor_id"], name: "index_pay_charges_on_customer_id_and_processor_id", unique: true
  end

  create_table "pay_customers", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "processor"
    t.string "processor_id"
    t.boolean "default"
    t.jsonb "data"
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_account"
    t.index ["owner_type", "owner_id", "deleted_at"], name: "customer_owner_processor_index"
    t.index ["processor", "processor_id"], name: "index_pay_customers_on_processor_and_processor_id"
  end

  create_table "pay_merchants", force: :cascade do |t|
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "processor"
    t.string "processor_id"
    t.boolean "default"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id", "processor"], name: "index_pay_merchants_on_owner_type_and_owner_id_and_processor"
  end

  create_table "pay_payment_methods", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "processor_id"
    t.boolean "default"
    t.string "type"
    t.jsonb "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_account"
    t.index ["customer_id", "processor_id"], name: "index_pay_payment_methods_on_customer_id_and_processor_id", unique: true
  end

  create_table "pay_subscriptions", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "processor_id", null: false
    t.string "processor_plan", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "trial_ends_at", precision: nil
    t.datetime "ends_at", precision: nil
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "status"
    t.jsonb "data"
    t.decimal "application_fee_percent", precision: 8, scale: 2
    t.jsonb "metadata"
    t.bigint "customer_id"
    t.datetime "current_period_start"
    t.datetime "current_period_end"
    t.boolean "metered"
    t.string "pause_behavior"
    t.datetime "pause_starts_at"
    t.datetime "pause_resumes_at"
    t.string "payment_method_id"
    t.string "stripe_account"
    t.index ["customer_id", "processor_id"], name: "index_pay_subscriptions_on_customer_id_and_processor_id", unique: true
    t.index ["metered"], name: "index_pay_subscriptions_on_metered"
    t.index ["pause_starts_at"], name: "index_pay_subscriptions_on_pause_starts_at"
  end

  create_table "pay_webhooks", force: :cascade do |t|
    t.string "processor"
    t.string "event_type"
    t.jsonb "event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string "name", null: false
    t.integer "amount", default: 0, null: false
    t.string "interval", null: false
    t.jsonb "details", default: {}, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "trial_period_days", default: 0
    t.boolean "hidden"
    t.string "currency"
    t.integer "interval_count", default: 1
    t.string "description"
    t.string "unit_label"
    t.boolean "charge_per_unit"
    t.string "stripe_id"
    t.string "braintree_id"
    t.string "paddle_billing_id"
    t.string "paddle_classic_id"
    t.string "lemon_squeezy_id"
    t.string "fake_processor_id"
    t.string "contact_url"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.string "time_zone"
    t.datetime "accepted_terms_at", precision: nil
    t.datetime "accepted_privacy_at", precision: nil
    t.datetime "announcements_read_at", precision: nil
    t.boolean "admin"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at", precision: nil
    t.datetime "invitation_sent_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "preferred_language"
    t.boolean "otp_required_for_login"
    t.string "otp_secret"
    t.integer "last_otp_timestep"
    t.text "otp_backup_codes"
    t.jsonb "preferences"
    t.virtual "name", type: :string, as: "(((first_name)::text || ' '::text) || (COALESCE(last_name, ''::character varying))::text)", stored: true
    t.datetime "last_sign_in_at"
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "sign_in_count", default: 0, null: false
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "admin_role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "witnesses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "claim_id", null: false
    t.string "witness_prefix"
    t.string "witness_name"
    t.string "witness_contact_number"
    t.string "witness_email"
    t.string "witness_physical_address"
    t.boolean "is_verified", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["claim_id"], name: "index_witnesses_on_claim_id"
  end

  add_foreign_key "account_invitations", "accounts"
  add_foreign_key "account_invitations", "users", column: "invited_by_id"
  add_foreign_key "account_users", "accounts"
  add_foreign_key "account_users", "users"
  add_foreign_key "accounts", "users", column: "owner_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "api_tokens", "users"
  add_foreign_key "claims", "municipalities"
  add_foreign_key "claims", "users"
  add_foreign_key "comments", "claims"
  add_foreign_key "comments", "users"
  add_foreign_key "damaged_items", "claims"
  add_foreign_key "municipalities", "accounts"
  add_foreign_key "pay_charges", "pay_customers", column: "customer_id"
  add_foreign_key "pay_payment_methods", "pay_customers", column: "customer_id"
  add_foreign_key "pay_subscriptions", "pay_customers", column: "customer_id"
  add_foreign_key "witnesses", "claims"
end
