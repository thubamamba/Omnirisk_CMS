class Witness < ApplicationRecord
  broadcasts_refreshes
  belongs_to :claim
  validate_uniqueness_of :witness_email
  validates :witness_prefix, presence: true
  validates :witness_name, presence: true
  validates :witness_contact_number, presence: true
  validates :witness_email, presence: true
  validates :witness_physical_address, presence: true

  # TODO: Add format to the number and validate emails to email
end
