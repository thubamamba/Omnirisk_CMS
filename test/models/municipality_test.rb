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
require "test_helper"

class MunicipalityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
