# == Schema Information
#
# Table name: municipalities
#
#  id         :uuid             not null, primary key
#  is_active  :boolean
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
# Indexes
#
#  index_municipalities_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Municipality < ApplicationRecord
  audited
  broadcasts_refreshes
  belongs_to :account

  validates :name, presence: true, uniqueness: { scope: :account_id }
end
