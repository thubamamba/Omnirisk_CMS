class RemoveUnsusedDeets3FromClaims < ActiveRecord::Migration[7.1]
  def change
    remove_column :claims, :accident_and_health_death_claim_claimant_first_name, :string
    remove_column :claims, :accident_and_health_death_claim_claimant_last_name, :string
  end
end
