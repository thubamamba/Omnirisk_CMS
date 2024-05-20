class AddMoreDeetsToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :liability_claim_type, :string
    add_column :claims, :public_liability_type, :string
    add_column :claims, :liability_owner_first_name, :string
    add_column :claims, :liability_owner_last_name, :string
    add_column :claims, :liability_owner_email_address, :string
    add_column :claims, :liability_owner_contact_number, :string
    add_column :claims, :liability_description_of_loss, :text
    add_column :claims, :liability_drivers_first_name, :string
    add_column :claims, :liability_drivers_last_name, :string
    add_column :claims, :liability_drivers_license_no, :string
    add_column :claims, :liability_drivers_license_date, :string
    add_column :claims, :liability_drivers_license_place, :string
    add_column :claims, :liability_drivers_license_status, :string
    add_column :claims, :liability_drivers_contact_number, :string
    add_column :claims, :liability_drivers_email, :string
    add_column :claims, :liability_drivers_physical_address, :string
    add_column :claims, :liability_registered_owner_first_name, :string
    add_column :claims, :liability_registered_owner_last_name, :string
    add_column :claims, :liability_registered_owner_address, :string
    add_column :claims, :liability_registered_owner_contact_number, :string
    add_column :claims, :liability_registered_owner_email, :string
    add_column :claims, :liability_contact_person_first_name, :string
    add_column :claims, :liability_contact_person_last_name, :string
    add_column :claims, :liability_contact_person_contact_number, :string
    add_column :claims, :liability_contact_person_email, :string
    add_column :claims, :liability_contact_person_physical_address, :string
    add_column :claims, :liability_assessment_contact_person_first_name, :string
    add_column :claims, :liability_assessment_contact_person_last_name, :string
    add_column :claims, :liability_assessment_contact_person_address, :string
    add_column :claims, :liability_assessment_contact_person_telephone_number, :string
    add_column :claims, :liability_vehicle_make, :string
    add_column :claims, :liability_vehicle_gross_vehicle_mass, :string
    add_column :claims, :liability_vehicle_registration_number, :string
    add_column :claims, :liability_vehicle_value, :string
    add_column :claims, :liability_vehicle_model, :string
    add_column :claims, :liability_vehicle_year, :string
    add_column :claims, :liability_vehicle_transmission_type, :string
    add_column :claims, :liability_vehicle_inspection_address, :string
  end
end