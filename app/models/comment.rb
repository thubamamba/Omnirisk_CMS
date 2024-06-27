class Comment < ApplicationRecord
  # TODO: Add audit trail
  broadcasts_refreshes
  belongs_to :claim
  belongs_to :user

  # Validation
  validates :description, presence: true
end
