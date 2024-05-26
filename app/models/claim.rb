# frozen_string_literal: true

class Claim < ApplicationRecord
  broadcasts_refreshes
  audited
  belongs_to :municipality
  has_one_attached :signature
  has_many_attached :property_claim_photos
  has_many_attached :liability_claim_photos
  has_many_attached :liability_motor_claim_photos
  has_many_attached :health_and_accident_documents
  has_one_attached :vehicle_claim_accident_sketch
  has_many_attached :vehicle_claim_supporting_docs

  enum claim_type: {
    property: 'Property',
    liability: 'Liability',
    accident_and_health: 'Accident and Health',
    vehicle: 'Vehicle'
  }

  enum liability_claim_type: {
    public_liability: 'Public Liability',
    motor_liability: 'Motor (MTPL) Liability'
  }

  enum public_liability_type: {
    property_damage: 'Property Damage',
    personal_injury: 'Personal Injury'
  }

  enum accident_and_health_claim_type: {
    death: 'Death Claim',
    disability: 'Disability Claim',
    medical: 'Medical Claim',
    ttr: 'Total and Temporary Income Replacement (TTR) Claim',
    hospitalization: 'Hospitalization Benefit Claim',
  }

  enum vehicle_claim_type: {
    owned_vehicle: 'Owned Vehicle',
    leased_vehicle: 'Leased Vehicle',
    financed_vehicle: 'Financed Vehicle',
  }

  # Custom regex

  # Validation
  # TODO: Audit trail to figure out how added this claim
  validates :municipality, presence: true
  # validates :claim_type, presence: true
  # TODO: Fix signature issue
  # validates :signature, attached: true, content_type: %w[image/png image/jpeg image/jpg], on: [:create]
  after_validation :accept_declaration, on: [:create]
  after_validation :accept_information_sharing, on: [:create]

  ### Validation for Property Claims
  validates :is_property_insured_elsewhere, inclusion: [true, false], presence: true, if: :property?
  # validates :is_property_insured_elsewhere_valid, presence: true, if: :property?
  validates :type_of_property_loss, presence: true, if: :property?
  validates :have_you_suffered_previous_loss, inclusion: { in: [true, false] }, if: :property?
  validates :has_other_party_interest, inclusion: { in: [true, false] }, if: :property?
  validates :date_of_loss, presence: true, if: :property?
  validates :insured_property_ownership, presence: true, if: :property?
  validates :was_property_occupied_during_damage, inclusion: { in: [true, false] }, if: :property?
  validates :description_of_incident, presence: true, if: :property?
  validates :incident_location, presence: true, if: :property?
  validates :property_claim_photos, attached: true, content_type: %w[image/png image/jpeg image/jpg], size: { between: 1.kilobyte..50.megabytes , message: 'is not given between size' }, if: :property?

  ### Validation for Liability Claims
  validates :public_liability_type, presence: true, if: :liability?
  validates :liability_owner_email_address, presence: true, 'valid_email_2/email': true, if: :liability?

  ## Validation for Property Liability Claims
  validates :public_liability_type, presence: true, if: :public_liability?
  validates :liability_is_claim_against_municipality, inclusion: { in: [true, false] }, if: :public_liability?
  validates :liability_personal_injury_place_of_occurrence, presence: true, if: :public_liability?
  validates :liability_personal_injury_date_of_occurrence, presence: true, if: :public_liability?

  ### Validation for Motor Liability Claims
  # Driver's details
  validates :liability_drivers_first_name, presence: true, if: :motor_liability?
  validates :liability_drivers_last_name, presence: true, if: :motor_liability?
  validates :liability_drivers_license_no, presence: true, if: :motor_liability?
  validates :liability_drivers_license_date, presence: true, if: :motor_liability?
  validates :liability_drivers_license_place, presence: true, if: :motor_liability?
  validates :liability_drivers_license_status, presence: true, if: :motor_liability?
  validates :liability_drivers_contact_number, presence: true, phone: {allow_blank: false, types: [:mobile, :fixed_line, :fixed_or_mobile]}, if: :motor_liability?
  validates :liability_drivers_email, presence: true, 'valid_email_2/email': true, if: :motor_liability?
  validates :liability_drivers_physical_address, presence: true, if: :motor_liability?
  # Registered owner details
  validates :liability_motor_claim_registered_owner_first_name, presence: true, if: :motor_liability?
  validates :liability_motor_claim_registered_owner_last_name, presence: true, if: :motor_liability?
  validates :liability_motor_claim_registered_owner_telephone_number, presence: true, phone: {allow_blank: false, types: [:mobile, :fixed_line, :fixed_or_mobile]}, if: :motor_liability?
  validates :liability_motor_claim_registered_owner_email, presence: true, 'valid_email_2/email': true, if: :motor_liability?
  validates :liability_motor_claim_registered_owner_physical_address, presence: true, if: :motor_liability?
  # Contact person details
  validates :liability_contact_person_first_name, presence: true, if: :motor_liability?
  validates :liability_contact_person_last_name, presence: true, if: :motor_liability?
  validates :liability_contact_person_physical_address, presence: true, if: :motor_liability?
  validates :liability_contact_person_contact_number, presence: true, phone: {allow_blank: false, types: [:mobile, :fixed_line, :fixed_or_mobile]}, if: :motor_liability?
  validates :liability_contact_person_email, presence: true, 'valid_email_2/email': true, if: :motor_liability?
  # Vehicle assessment
  validates :liability_assessment_contact_person_first_name, presence: true, if: :motor_liability?
  validates :liability_assessment_contact_person_last_name, presence: true, if: :motor_liability?
  validates :liability_assessment_contact_person_address, presence: true, if: :motor_liability?
  validates :liability_assessment_contact_person_telephone_number, presence: true, phone: {allow_blank: false, types: [:mobile, :fixed_line, :fixed_or_mobile]}, if: :motor_liability?
  # Vehicle Details
  validates :liability_vehicle_make, presence: true, if: :motor_liability?
  validates :liability_vehicle_gross_vehicle_mass, presence: true, numericality: { only_integer: true }, if: :motor_liability?
  validates :liability_vehicle_registration_number, presence: true, if: :motor_liability?
  validates :liability_vehicle_value, presence: true, numericality: { only_integer: true }, if: :motor_liability?
  # TODO: ensure this works fine
  validates :liability_vehicle_model, presence: true, if: :motor_liability?
  validates :liability_vehicle_year, presence: true, numericality: { only_integer: true }, if: :motor_liability?
  validates :liability_vehicle_transmission_type, presence: true, if: :motor_liability?
  validates :liability_vehicle_km_completed, presence: true, numericality: { only_integer: true }, if: :motor_liability?
  validates :liability_vehicle_drivable, presence: true, if: :motor_liability?
  validates :liability_vehicle_towed, presence: true, inclusion: [true, false], if: :motor_liability?
  validates :liability_vehicle_inspection_address, presence: true, if: :motor_liability?
  # Imagery
  validates :liability_motor_claim_photos, attached: true, content_type: %w[image/png image/jpeg image/jpg], size: { between: 1.kilobyte..50.megabytes , message: 'is not given between size' }, if: :motor_liability?

  ### Validation for Accident and Health Claims
  validates :accident_and_health_claim_type, presence: true, if: :accident_and_health?
  validates :accident_and_health_claimant_first_name, presence: true, if: :accident_and_health?
  validates :accident_and_health_claimant_last_name, presence: true, if: :accident_and_health?
  validates :accident_and_health_claimant_occupation, presence: true, if: :accident_and_health?
  validates :accident_and_health_claimant_id_number, presence: true, numericality: { only_integer: true }, length: { maximum: 13 }, if: :accident_and_health?
  validates :health_and_accident_documents, attached: true, content_type: %w[image/png image/jpeg image/jpg application/pdf], size: { between: 1.kilobyte..50.megabytes , message: 'is not given between size' }, presence: false

  # Death Claim validations
  # validates :accident_and_health_death_claim_claimant_first_name, presence: true, if: :death?
  # validates :accident_and_health_death_claim_claimant_last_name, presence: true, if: :death?
  validates :accident_and_health_death_claim_claimant_employee_status, presence: true, if: :death?
  validates :accident_and_health_death_claim_about_claimant_occupation, presence: true, if: :death?
  validates :accident_and_health_death_claim_date_of_death, presence: true, if: :death?
  validates :accident_and_health_death_claim_place_of_death, presence: true, if: :death?
  validates :accident_and_health_death_claim_death_cause, presence: true, if: :death?
  validates :accident_and_health_death_claim_any_factors_to_death_cause, presence: true, if: :death?

  # Disability claim validations
  validates :accident_and_health_disability_claim_accident_date, presence: true, if: :disability?
  validates :accident_and_health_disability_claim_accident_place, presence: true, if: :disability?
  validates :accident_and_health_disability_claim_description_of_accident, presence: true, if: :disability?
  validates :accident_and_health_claim_attending_doctor_practice_number, presence: true, if: :disability?
  validates :accident_and_health_claim_attending_doctor_address, presence: true, if: :disability?
  validates :accident_and_health_disability_claim_is_permanently_disabled, inclusion: [true, false], presence: true, if: :disability?
  validates :accident_and_health_disability_claim_was_person_on_duty, inclusion: [true, false], presence: true, if: :disability?

  # Medical claim validations
  validates :health_and_accident_documents, attached: true, content_type: %w[image/png image/jpeg image/jpg application/pdf], size: { between: 1.kilobyte..50.megabytes , message: 'is not given between size' }, presence: false, if: :medical?

  #### Validation for Vehicle Claims
  validates :vehicle_claim_type, presence: true, if: :vehicle?
  validates :vehicle_claim_police_no, presence: true, if: :vehicle?
  validates :vehicle_claim_accident_address, presence: true, if: :vehicle?
  validates :vehicle_claim_leaser_of_financier, presence: true, if: :vehicle?
  validates :vehicle_claim_date_of_loss, presence: true, if: :vehicle?
  validates :vehicle_claim_vehicle_model, presence: true, if: :vehicle?
  validates :vehicle_claim_vehicle_manufacturer, presence: true, if: :vehicle?
  validates :vehicle_claim_vehicle_km_completed, presence: true, if: :vehicle?
  validates :vehicle_claim_vehicle_registration, presence: true, if: :vehicle?
  validates :vehicle_claim_vehicle_drivers_first_name, presence: true, if: :vehicle?
  validates :vehicle_claim_vehicle_drivers_last_name, presence: true, if: :vehicle?
  validates :vehicle_claim_vehicle_drivers_id_number, presence: true, if: :vehicle?
  validates :vehicle_claim_vehicle_drivers_occupation, presence: true, if: :vehicle?
  validates :vehicle_claim_vehicle_drivers_license_code, presence: true, if: :vehicle?
  validates :vehicle_claim_were_there_passengers, presence: true, if: :vehicle?
  validates :vehicle_claim_were_there_witnesses, presence: true, if: :vehicle?
  validates :vehicle_claim_accident_description, presence: true, if: :vehicle?
  validates :vehicle_claim_is_municipal_vehicle_damaged, presence: true, if: :vehicle?
  validates :vehicle_claim_was_driver_authorized, presence: true, if: :vehicle?
  validates :vehicle_claim_is_driver_your_employee, presence: true, if: :vehicle?
  validates :vehicle_claim_is_driver_your_employee, presence: true, if: :vehicle?
  validates :vehicle_claim_has_drivers_license_been_suspended, presence: true, if: :vehicle?
  validates :vehicle_claim_driver_physical_defects_status, presence: true, if: :vehicle?
  validates :vehicle_claim_vehicle_purposes, presence: true, if: :vehicle?
  validates :vehicle_claim_any_other_vehicle_damaged, presence: true, if: :vehicle?
  validates :vehicle_claim_was_vehicle_stolen_hijacked, presence: true, if: :vehicle?

  # Imagery
  validates :vehicle_claim_accident_sketch, attached: true, content_type: %w[image/png image/jpeg image/jpg], size: { between: 1.kilobyte..50.megabytes , message: 'is not given between size' }, if: :vehicle?
  validates :vehicle_claim_supporting_docs, attached: true, content_type: %w[image/png image/jpeg image/jpg application/pdf], size: { between: 1.kilobyte..50.megabytes , message: 'is not given between size' }, if: :vehicle?

  # Auto generate claim number on create
  before_create :generate_claim_number
  # Auto assign claim status on create
  before_create :assign_claim_status

  def accept_declaration
    self.declaration_accepted_at = Time.zone.now
  end

  def accept_information_sharing
    self.information_sharing_accepted_at = Time.zone.now
  end

  def generate_claim_number
    self.claim_number = SecureRandom.hex(6)
  end

  def assign_claim_status
    self.status = 'Incoming'
  end

  CLAIM_STATUS = ['Incoming', 'Reviewing Claim', 'Submitted to Underwriter', 'Awaiting Outstanding Documents',
                  'Awaiting Feedback from Underwriter', 'Awaiting Assessors Report', 'Awaiting Internal Advice',
                  'Awaiting Excess Payment', 'Awaiting AOL from underwriter', 'Awaiting signed AOL', 'Awaiting POP',
                  'Not taken up', 'Awaiting TP approach', 'Repairs Authorized', 'Claims fall within Excess', 'Approved',
                  'Rejected'].freeze

  LIABILITY_DRIVERS_LICENSE_STATUS =%w[Learner Full].freeze
  LIABILITY_VEHICLE_TRANSMISSION_TYPE = %w[Manual Automatic].freeze
  LIABILITY_VEHICLE_DRIVABLE = %w[Yes No].freeze
  DEATH_CLAIMANT_EMPLOYEE_STATUS = %w[Yes No].freeze
  DEATH_CLAIM_CONFIRMATION_OF_FORM_ACCURACY = %w[Yes No].freeze
  DEATH_CLAIM_ADDITIONAL_FACTORS_TO_DEATH_CAUSE = %w[Yes No].freeze

  private

  def self.claim_type_options
    claim_types.keys.map { |key| [humanized_options(key), key] }
  end

  def self.liability_claim_type_options
    liability_claim_types.keys.map { |key| [humanized_options(key), key] }
  end

  def self.public_liability_type_options
    public_liability_types.keys.map { |key| [humanized_options(key), key] }
  end

  def self.accident_and_health_claim_type_options
    accident_and_health_claim_types.keys.map { |key| [humanized_options(key), key] }
  end

  def self.vehicle_claim_type_options
    vehicle_claim_types.keys.map { |key| [humanized_options(key), key] }
  end

  def self.humanized_options(key)
    key.split('_').map(&:capitalize).join(' ')
  end
end
