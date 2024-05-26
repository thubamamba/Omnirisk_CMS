class RenameVehicleClaimsColumnsInClaims < ActiveRecord::Migration[7.1]
  def change
    rename_column :claims, :owned_vehicle_claim_police_no, :vehicle_claim_police_no
    rename_column :claims, :owned_vehicle_claim_accident_address, :vehicle_claim_accident_address
    rename_column :claims, :owned_vehicle_claim_date_of_loss, :vehicle_claim_date_of_loss
  end
end
