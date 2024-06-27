class AddVehicleClaimToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :vehicle_claim_type, :string
    add_column :claims, :owned_vehicle_claim_police_no, :string
    add_column :claims, :owned_vehicle_claim_accident_address, :string
    add_column :claims, :owned_vehicle_claim_date_of_loss, :string
    add_column :claims, :vehicle_claim_vehicle_model, :string
    add_column :claims, :vehicle_claim_vehicle_manufacturer, :string
    add_column :claims, :vehicle_claim_vehicle_km_completed, :string
    add_column :claims, :vehicle_claim_vehicle_registration, :string
    add_column :claims, :vehicle_claim_vehicle_drivers_first_name, :string
    add_column :claims, :vehicle_claim_vehicle_drivers_last_name, :string
    add_column :claims, :vehicle_claim_vehicle_drivers_id_number, :string
    add_column :claims, :vehicle_claim_vehicle_drivers_occupation, :string
    add_column :claims, :vehicle_claim_vehicle_drivers_license_code, :string
    add_column :claims, :vehicle_claim_were_there_passengers, :string
    add_column :claims, :vehicle_claim_were_there_witnesses, :string
    add_column :claims, :vehicle_claim_accident_description, :text
    add_column :claims, :vehicle_claim_is_municipal_vehicle_damaged, :string
    add_column :claims, :vehicle_claim_was_driver_authorized, :string
    add_column :claims, :vehicle_claim_is_driver_your_employee, :string
    add_column :claims, :vehicle_claim_has_drivers_license_been_suspended, :string
    add_column :claims, :vehicle_claim_driver_physical_defects_status, :string
    add_column :claims, :vehicle_claim_vehicle_purposes, :string
    add_column :claims, :vehicle_claim_any_other_vehicle_damaged, :string
    add_column :claims, :vehicle_claim_was_vehicle_stolen_hijacked, :string
  end
end
