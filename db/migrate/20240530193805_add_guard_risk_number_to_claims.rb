class AddGuardRiskNumberToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :guard_risk_claim_number, :string
  end
end
