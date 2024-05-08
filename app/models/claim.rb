# frozen_string_literal: true

class Claim < ApplicationRecord
  broadcasts_refreshes
  belongs_to :municipality
  has_many_attached :property_claim_photos
  # enum claim_type: [:property, :liability, :accident, :vehicle], validate: true

  # Validation
  # TODO: Audit trail to figure out how added this claim
  validates :municipality, presence: true
  validates :claim_type, presence: true
  after_validation :accept_declaration, on: [:create]
  after_validation :accept_information_sharing, on: [:create]

  # Validation for Property Claims
  validates :is_property_insured_elsewhere, inclusion: { in: [true, false] }, if: :property_claim?
  validates :type_of_property_loss, presence: true, if: :property_claim?
  validates :have_you_suffered_previous_loss, inclusion: { in: [true, false] }, if: :property_claim?
  validates :has_other_party_interest, inclusion: { in: [true, false] }, if: :property_claim?
  validates :date_of_loss, presence: true, if: :property_claim?
  validates :insured_property_ownership, presence: true, if: :property_claim?
  validates :was_property_occupied_during_damage, inclusion: { in: [true, false] }, if: :property_claim?
  validates :description_of_incident, presence: true, if: :property_claim?
  validates :incident_location, presence: true, if: :property_claim?

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

  def property_claim?
    claim_type == 'Property'
  end

  def liability_claim?
    claim_type == 'liability'
  end

  def accident_claim?
    claim_type == 'Accident and Health'
  end

  def vehicle_claim?
    claim_type == 'Vehicle'
  end

  def generate_claim_number
    self.claim_number = SecureRandom.hex(6)
  end

  def assign_claim_status
    self.status = 'Incoming'
  end

  CLAIM_TYPE = ['Property', 'Liability', 'Accident and Health', 'Vehicle'].freeze
  CLAIM_STATUS = ['Incoming', 'Reviewing Claim', 'Submitted to Underwriter', 'Awaiting Outstanding Documents',
                  'Awaiting Feedback from Underwriter', 'Awaiting Assessors Report', 'Awaiting Internal Advice',
                  'Awaiting Excess Payment', 'Awaiting AOL from underwriter', 'Awaiting signed AOL', 'Awaiting POP',
                  'Not taken up', 'Awaiting TP approach', 'Repairs Authorized', 'Claims fall within Excess', 'Approved',
                  'Rejected'].freeze
end