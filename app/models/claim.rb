# frozen_string_literal: true

class Claim < ApplicationRecord
  broadcasts_refreshes
  audited
  belongs_to :municipality
  has_one_attached :signature
  has_many_attached :property_claim_photos
  has_many_attached :liability_claim_photos

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

  # Validation
  # TODO: Audit trail to figure out how added this claim
  validates :municipality, presence: true
  # validates :claim_type, presence: true
  validates :signature, attached: true, content_type: %w[image/png image/jpeg image/jpg], on: [:create]
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
  validates :property_claim_photos, attached: true, content_type: %w[image/png image/jpeg image/jpg], if: :property?

  ### Validation for Liability Claims
  validates :public_liability_type, presence: true, if: :liability?
  validates :liability_owner_email_address, email: true, presence: true, if: :liability?

  ## Validation for Property Liability Claims


  ### Validation for Motor Liability Claims


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

  def self.humanized_options(key)
    key.split('_').map(&:capitalize).join(' ')
  end

  # def is_property_insured_elsewhere_valid
  #   return if is_property_insured_elsewhere.present? || [true, false].include?(is_property_insured_elsewhere)
  #
  #   errors.add(:is_property_insured_elsewhere, 'must be present and true or false')
  #
  # end
end