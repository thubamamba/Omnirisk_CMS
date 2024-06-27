class Witness < ApplicationRecord
  broadcasts_refreshes
  belongs_to :claim
  # validate_uniqueness_of :witness_email
  # validates :witness_prefix, presence: true
  # validates :witness_name, presence: true
  # validates :witness_contact_number, presence: true
  # validates :witness_email, presence: true
  # validates :witness_physical_address, presence: true

  validates :witness_contact_number, phone: {allow_blank: false, types: [:mobile, :fixed_line, :fixed_or_mobile]}
  validates :witness_email,
            "valid_email_2/email": {
              blacklist: true,
              message: "is not a valid email"
            }
end
