require "administrate/base_dashboard"

class ClaimDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::String,
    accident_and_health_claim_attending_doctor_address: Field::String,
    accident_and_health_claim_attending_doctor_contact_number: Field::String,
    accident_and_health_claim_attending_doctor_first_name: Field::String,
    accident_and_health_claim_attending_doctor_last_name: Field::String,
    accident_and_health_claim_attending_doctor_practice_number: Field::String,
    accident_and_health_claim_type: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    accident_and_health_claimant_first_name: Field::String,
    accident_and_health_claimant_id_number: Field::String,
    accident_and_health_claimant_last_name: Field::String,
    accident_and_health_claimant_occupation: Field::String,
    accident_and_health_death_claim_about_claimant_occupation: Field::Text,
    accident_and_health_death_claim_any_factors_to_death_cause: Field::String,
    accident_and_health_death_claim_claimant_employee_status: Field::String,
    accident_and_health_death_claim_confirmation_of_form_accuracy: Field::String,
    accident_and_health_death_claim_date_of_death: Field::Date,
    accident_and_health_death_claim_death_cause: Field::String,
    accident_and_health_death_claim_place_of_death: Field::String,
    accident_and_health_disability_claim_accident_date: Field::Date,
    accident_and_health_disability_claim_accident_place: Field::String,
    accident_and_health_disability_claim_description_of_accident: Field::Text,
    accident_and_health_disability_claim_is_permanently_disabled: Field::Boolean,
    accident_and_health_disability_claim_saps_and_oar_case_no: Field::String,
    accident_and_health_disability_claim_was_person_on_duty: Field::Boolean,
    accident_and_health_ttd_claim_description_of_injuries: Field::Text,
    audits: Field::HasMany,
    bank_details_account_holder_name: Field::String,
    bank_details_account_number: Field::String,
    bank_details_bank_name: Field::String,
    bank_details_branch_code: Field::String,
    claim_number: Field::String,
    claim_type: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    comments: Field::HasMany,
    damaged_items: Field::HasMany,
    date_of_loss: Field::DateTime,
    declaration_accepted_at: Field::DateTime,
    description_of_incident: Field::Text,
    guard_risk_claim_number: Field::String,
    has_other_party_interest: Field::Boolean,
    have_you_suffered_previous_loss: Field::Boolean,
    health_and_accident_documents_attachments: Field::HasMany,
    health_and_accident_documents_blobs: Field::HasMany,
    incident_location: Field::String,
    information_sharing_accepted_at: Field::DateTime,
    insured_property_ownership: Field::String,
    is_active: Field::Boolean,
    is_property_insured_elsewhere: Field::Boolean,
    liability_assessment_contact_person_address: Field::String,
    liability_assessment_contact_person_first_name: Field::String,
    liability_assessment_contact_person_last_name: Field::String,
    liability_assessment_contact_person_telephone_number: Field::String,
    liability_claim_details: Field::Text,
    liability_claim_photos_attachments: Field::HasMany,
    liability_claim_photos_blobs: Field::HasMany,
    liability_claim_type: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    liability_contact_person_contact_number: Field::String,
    liability_contact_person_email: Field::String,
    liability_contact_person_first_name: Field::String,
    liability_contact_person_last_name: Field::String,
    liability_contact_person_physical_address: Field::String,
    liability_description_of_incident: Field::Text,
    liability_description_of_loss: Field::Text,
    liability_drivers_contact_number: Field::String,
    liability_drivers_email: Field::String,
    liability_drivers_first_name: Field::String,
    liability_drivers_last_name: Field::String,
    liability_drivers_license_date: Field::String,
    liability_drivers_license_no: Field::String,
    liability_drivers_license_place: Field::String,
    liability_drivers_license_status: Field::String,
    liability_drivers_physical_address: Field::String,
    liability_is_claim_against_municipality: Field::Boolean,
    liability_motor_claim_photos_attachments: Field::HasMany,
    liability_motor_claim_photos_blobs: Field::HasMany,
    liability_motor_claim_registered_owner_email: Field::String,
    liability_motor_claim_registered_owner_first_name: Field::String,
    liability_motor_claim_registered_owner_last_name: Field::String,
    liability_motor_claim_registered_owner_physical_address: Field::String,
    liability_motor_claim_registered_owner_telephone_number: Field::String,
    liability_owner_contact_number: Field::String,
    liability_owner_email_address: Field::String,
    liability_owner_first_name: Field::String,
    liability_owner_last_name: Field::String,
    liability_personal_injury_address_of_injured_person: Field::String,
    liability_personal_injury_age_of_injured_person: Field::String,
    liability_personal_injury_date_of_occurrence: Field::Date,
    liability_personal_injury_details: Field::Text,
    liability_personal_injury_first_name_of_injured_person: Field::String,
    liability_personal_injury_last_name_of_injured_person: Field::String,
    liability_personal_injury_place_of_occurrence: Field::String,
    liability_property_police_officer_first_name: Field::String,
    liability_property_police_officer_last_name: Field::String,
    liability_property_police_ref_number: Field::String,
    liability_property_police_report_date: Field::Date,
    liability_property_police_station_case_reported_to: Field::String,
    liability_property_witness_contact_number: Field::String,
    liability_property_witness_first_name: Field::String,
    liability_property_witness_last_name: Field::String,
    liability_vehicle_drivable: Field::String,
    liability_vehicle_gross_vehicle_mass: Field::String,
    liability_vehicle_inspection_address: Field::String,
    liability_vehicle_km_completed: Field::String,
    liability_vehicle_make: Field::String,
    liability_vehicle_model: Field::String,
    liability_vehicle_registration_number: Field::String,
    liability_vehicle_towed: Field::Boolean,
    liability_vehicle_transmission_type: Field::String,
    liability_vehicle_value: Field::String,
    liability_vehicle_year: Field::String,
    municipality: Field::BelongsTo,
    nature_of_incident: Field::String,
    police_ref_number: Field::String,
    police_station_incident_reported_to: Field::String,
    property_claim_photos_docs_attachments: Field::HasMany,
    property_claim_photos_docs_blobs: Field::HasMany,
    property_loss_location: Field::Text,
    public_liability_type: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    signature_attachment: Field::HasOne,
    signature_blob: Field::HasOne,
    status: Field::String,
    type_of_property_loss: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    user: Field::BelongsTo,
    vehicle_claim_accident_address: Field::String,
    vehicle_claim_accident_description: Field::Text,
    vehicle_claim_accident_sketch_attachment: Field::HasOne,
    vehicle_claim_accident_sketch_blob: Field::HasOne,
    vehicle_claim_any_other_vehicle_damaged: Field::String,
    vehicle_claim_date_of_loss: Field::String,
    vehicle_claim_driver_physical_defects_status: Field::String,
    vehicle_claim_has_drivers_license_been_suspended: Field::String,
    vehicle_claim_is_driver_your_employee: Field::String,
    vehicle_claim_is_municipal_vehicle_damaged: Field::String,
    vehicle_claim_leaser_of_financier: Field::String,
    vehicle_claim_police_no: Field::String,
    vehicle_claim_supporting_docs_attachments: Field::HasMany,
    vehicle_claim_supporting_docs_blobs: Field::HasMany,
    vehicle_claim_type: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    vehicle_claim_vehicle_drivers_first_name: Field::String,
    vehicle_claim_vehicle_drivers_id_number: Field::String,
    vehicle_claim_vehicle_drivers_last_name: Field::String,
    vehicle_claim_vehicle_drivers_license_code: Field::String,
    vehicle_claim_vehicle_drivers_occupation: Field::String,
    vehicle_claim_vehicle_km_completed: Field::String,
    vehicle_claim_vehicle_manufacturer: Field::String,
    vehicle_claim_vehicle_model: Field::String,
    vehicle_claim_vehicle_purposes: Field::String,
    vehicle_claim_vehicle_registration: Field::String,
    vehicle_claim_was_driver_authorized: Field::String,
    vehicle_claim_was_vehicle_stolen_hijacked: Field::String,
    vehicle_claim_were_there_passengers: Field::String,
    vehicle_claim_were_there_witnesses: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    vehicle_value: Field::String,
    was_property_occupied_during_damage: Field::Boolean,
    witnesses: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    municipality
    claim_type
    user
    status
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    accident_and_health_claim_attending_doctor_address
    accident_and_health_claim_attending_doctor_contact_number
    accident_and_health_claim_attending_doctor_first_name
    accident_and_health_claim_attending_doctor_last_name
    accident_and_health_claim_attending_doctor_practice_number
    accident_and_health_claim_type
    accident_and_health_claimant_first_name
    accident_and_health_claimant_id_number
    accident_and_health_claimant_last_name
    accident_and_health_claimant_occupation
    accident_and_health_death_claim_about_claimant_occupation
    accident_and_health_death_claim_any_factors_to_death_cause
    accident_and_health_death_claim_claimant_employee_status
    accident_and_health_death_claim_confirmation_of_form_accuracy
    accident_and_health_death_claim_date_of_death
    accident_and_health_death_claim_death_cause
    accident_and_health_death_claim_place_of_death
    accident_and_health_disability_claim_accident_date
    accident_and_health_disability_claim_accident_place
    accident_and_health_disability_claim_description_of_accident
    accident_and_health_disability_claim_is_permanently_disabled
    accident_and_health_disability_claim_saps_and_oar_case_no
    accident_and_health_disability_claim_was_person_on_duty
    accident_and_health_ttd_claim_description_of_injuries
    audits
    bank_details_account_holder_name
    bank_details_account_number
    bank_details_bank_name
    bank_details_branch_code
    claim_number
    claim_type
    comments
    damaged_items
    date_of_loss
    declaration_accepted_at
    description_of_incident
    guard_risk_claim_number
    has_other_party_interest
    have_you_suffered_previous_loss
    health_and_accident_documents_attachments
    health_and_accident_documents_blobs
    incident_location
    information_sharing_accepted_at
    insured_property_ownership
    is_active
    is_property_insured_elsewhere
    liability_assessment_contact_person_address
    liability_assessment_contact_person_first_name
    liability_assessment_contact_person_last_name
    liability_assessment_contact_person_telephone_number
    liability_claim_details
    liability_claim_photos_attachments
    liability_claim_photos_blobs
    liability_claim_type
    liability_contact_person_contact_number
    liability_contact_person_email
    liability_contact_person_first_name
    liability_contact_person_last_name
    liability_contact_person_physical_address
    liability_description_of_incident
    liability_description_of_loss
    liability_drivers_contact_number
    liability_drivers_email
    liability_drivers_first_name
    liability_drivers_last_name
    liability_drivers_license_date
    liability_drivers_license_no
    liability_drivers_license_place
    liability_drivers_license_status
    liability_drivers_physical_address
    liability_is_claim_against_municipality
    liability_motor_claim_photos_attachments
    liability_motor_claim_photos_blobs
    liability_motor_claim_registered_owner_email
    liability_motor_claim_registered_owner_first_name
    liability_motor_claim_registered_owner_last_name
    liability_motor_claim_registered_owner_physical_address
    liability_motor_claim_registered_owner_telephone_number
    liability_owner_contact_number
    liability_owner_email_address
    liability_owner_first_name
    liability_owner_last_name
    liability_personal_injury_address_of_injured_person
    liability_personal_injury_age_of_injured_person
    liability_personal_injury_date_of_occurrence
    liability_personal_injury_details
    liability_personal_injury_first_name_of_injured_person
    liability_personal_injury_last_name_of_injured_person
    liability_personal_injury_place_of_occurrence
    liability_property_police_officer_first_name
    liability_property_police_officer_last_name
    liability_property_police_ref_number
    liability_property_police_report_date
    liability_property_police_station_case_reported_to
    liability_property_witness_contact_number
    liability_property_witness_first_name
    liability_property_witness_last_name
    liability_vehicle_drivable
    liability_vehicle_gross_vehicle_mass
    liability_vehicle_inspection_address
    liability_vehicle_km_completed
    liability_vehicle_make
    liability_vehicle_model
    liability_vehicle_registration_number
    liability_vehicle_towed
    liability_vehicle_transmission_type
    liability_vehicle_value
    liability_vehicle_year
    municipality
    nature_of_incident
    police_ref_number
    police_station_incident_reported_to
    property_claim_photos_docs_attachments
    property_claim_photos_docs_blobs
    property_loss_location
    public_liability_type
    signature_attachment
    signature_blob
    status
    type_of_property_loss
    user
    vehicle_claim_accident_address
    vehicle_claim_accident_description
    vehicle_claim_accident_sketch_attachment
    vehicle_claim_accident_sketch_blob
    vehicle_claim_any_other_vehicle_damaged
    vehicle_claim_date_of_loss
    vehicle_claim_driver_physical_defects_status
    vehicle_claim_has_drivers_license_been_suspended
    vehicle_claim_is_driver_your_employee
    vehicle_claim_is_municipal_vehicle_damaged
    vehicle_claim_leaser_of_financier
    vehicle_claim_police_no
    vehicle_claim_supporting_docs_attachments
    vehicle_claim_supporting_docs_blobs
    vehicle_claim_type
    vehicle_claim_vehicle_drivers_first_name
    vehicle_claim_vehicle_drivers_id_number
    vehicle_claim_vehicle_drivers_last_name
    vehicle_claim_vehicle_drivers_license_code
    vehicle_claim_vehicle_drivers_occupation
    vehicle_claim_vehicle_km_completed
    vehicle_claim_vehicle_manufacturer
    vehicle_claim_vehicle_model
    vehicle_claim_vehicle_purposes
    vehicle_claim_vehicle_registration
    vehicle_claim_was_driver_authorized
    vehicle_claim_was_vehicle_stolen_hijacked
    vehicle_claim_were_there_passengers
    vehicle_claim_were_there_witnesses
    vehicle_value
    was_property_occupied_during_damage
    witnesses
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    accident_and_health_claim_attending_doctor_address
    accident_and_health_claim_attending_doctor_contact_number
    accident_and_health_claim_attending_doctor_first_name
    accident_and_health_claim_attending_doctor_last_name
    accident_and_health_claim_attending_doctor_practice_number
    accident_and_health_claim_type
    accident_and_health_claimant_first_name
    accident_and_health_claimant_id_number
    accident_and_health_claimant_last_name
    accident_and_health_claimant_occupation
    accident_and_health_death_claim_about_claimant_occupation
    accident_and_health_death_claim_any_factors_to_death_cause
    accident_and_health_death_claim_claimant_employee_status
    accident_and_health_death_claim_confirmation_of_form_accuracy
    accident_and_health_death_claim_date_of_death
    accident_and_health_death_claim_death_cause
    accident_and_health_death_claim_place_of_death
    accident_and_health_disability_claim_accident_date
    accident_and_health_disability_claim_accident_place
    accident_and_health_disability_claim_description_of_accident
    accident_and_health_disability_claim_is_permanently_disabled
    accident_and_health_disability_claim_saps_and_oar_case_no
    accident_and_health_disability_claim_was_person_on_duty
    accident_and_health_ttd_claim_description_of_injuries
    audits
    bank_details_account_holder_name
    bank_details_account_number
    bank_details_bank_name
    bank_details_branch_code
    claim_number
    claim_type
    comments
    damaged_items
    date_of_loss
    declaration_accepted_at
    description_of_incident
    guard_risk_claim_number
    has_other_party_interest
    have_you_suffered_previous_loss
    health_and_accident_documents_attachments
    health_and_accident_documents_blobs
    incident_location
    information_sharing_accepted_at
    insured_property_ownership
    is_active
    is_property_insured_elsewhere
    liability_assessment_contact_person_address
    liability_assessment_contact_person_first_name
    liability_assessment_contact_person_last_name
    liability_assessment_contact_person_telephone_number
    liability_claim_details
    liability_claim_photos_attachments
    liability_claim_photos_blobs
    liability_claim_type
    liability_contact_person_contact_number
    liability_contact_person_email
    liability_contact_person_first_name
    liability_contact_person_last_name
    liability_contact_person_physical_address
    liability_description_of_incident
    liability_description_of_loss
    liability_drivers_contact_number
    liability_drivers_email
    liability_drivers_first_name
    liability_drivers_last_name
    liability_drivers_license_date
    liability_drivers_license_no
    liability_drivers_license_place
    liability_drivers_license_status
    liability_drivers_physical_address
    liability_is_claim_against_municipality
    liability_motor_claim_photos_attachments
    liability_motor_claim_photos_blobs
    liability_motor_claim_registered_owner_email
    liability_motor_claim_registered_owner_first_name
    liability_motor_claim_registered_owner_last_name
    liability_motor_claim_registered_owner_physical_address
    liability_motor_claim_registered_owner_telephone_number
    liability_owner_contact_number
    liability_owner_email_address
    liability_owner_first_name
    liability_owner_last_name
    liability_personal_injury_address_of_injured_person
    liability_personal_injury_age_of_injured_person
    liability_personal_injury_date_of_occurrence
    liability_personal_injury_details
    liability_personal_injury_first_name_of_injured_person
    liability_personal_injury_last_name_of_injured_person
    liability_personal_injury_place_of_occurrence
    liability_property_police_officer_first_name
    liability_property_police_officer_last_name
    liability_property_police_ref_number
    liability_property_police_report_date
    liability_property_police_station_case_reported_to
    liability_property_witness_contact_number
    liability_property_witness_first_name
    liability_property_witness_last_name
    liability_vehicle_drivable
    liability_vehicle_gross_vehicle_mass
    liability_vehicle_inspection_address
    liability_vehicle_km_completed
    liability_vehicle_make
    liability_vehicle_model
    liability_vehicle_registration_number
    liability_vehicle_towed
    liability_vehicle_transmission_type
    liability_vehicle_value
    liability_vehicle_year
    municipality
    nature_of_incident
    police_ref_number
    police_station_incident_reported_to
    property_claim_photos_docs_attachments
    property_claim_photos_docs_blobs
    property_loss_location
    public_liability_type
    signature_attachment
    signature_blob
    status
    type_of_property_loss
    user
    vehicle_claim_accident_address
    vehicle_claim_accident_description
    vehicle_claim_accident_sketch_attachment
    vehicle_claim_accident_sketch_blob
    vehicle_claim_any_other_vehicle_damaged
    vehicle_claim_date_of_loss
    vehicle_claim_driver_physical_defects_status
    vehicle_claim_has_drivers_license_been_suspended
    vehicle_claim_is_driver_your_employee
    vehicle_claim_is_municipal_vehicle_damaged
    vehicle_claim_leaser_of_financier
    vehicle_claim_police_no
    vehicle_claim_supporting_docs_attachments
    vehicle_claim_supporting_docs_blobs
    vehicle_claim_type
    vehicle_claim_vehicle_drivers_first_name
    vehicle_claim_vehicle_drivers_id_number
    vehicle_claim_vehicle_drivers_last_name
    vehicle_claim_vehicle_drivers_license_code
    vehicle_claim_vehicle_drivers_occupation
    vehicle_claim_vehicle_km_completed
    vehicle_claim_vehicle_manufacturer
    vehicle_claim_vehicle_model
    vehicle_claim_vehicle_purposes
    vehicle_claim_vehicle_registration
    vehicle_claim_was_driver_authorized
    vehicle_claim_was_vehicle_stolen_hijacked
    vehicle_claim_were_there_passengers
    vehicle_claim_were_there_witnesses
    vehicle_value
    was_property_occupied_during_damage
    witnesses
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how claims are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(claim)
  #   "Claim ##{claim.id}"
  # end
end
