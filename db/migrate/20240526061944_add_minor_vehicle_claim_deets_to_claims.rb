class AddMinorVehicleClaimDeetsToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :vehicle_claim_leaser_of_financier, :string
  end
end
