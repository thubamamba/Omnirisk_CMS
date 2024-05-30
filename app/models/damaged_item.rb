class DamagedItem < ApplicationRecord
  broadcasts_refreshes
  belongs_to :claim

  validates :item_name, presence: true
  validates :serial_number, presence: true
  validates :estimated_value, presence: true
end
