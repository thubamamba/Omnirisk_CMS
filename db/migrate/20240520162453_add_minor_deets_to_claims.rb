class AddMinorDeetsToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :liability_vehicle_km_completed, :string
    add_column :claims, :vehicle_value, :string
    add_column :claims, :liability_vehicle_drivable, :string
    add_column :claims, :liability_vehicle_towed, :boolean
  end
end
