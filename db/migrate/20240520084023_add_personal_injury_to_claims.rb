class AddPersonalInjuryToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :liability_property_witness_first_name, :string
    add_column :claims, :liability_property_witness_last_name, :string
    add_column :claims, :liability_property_witness_contact_number, :string
    add_column :claims, :liability_property_police_ref_number, :string
    add_column :claims, :liability_property_police_station_case_reported_to, :string
    add_column :claims, :liability_property_police_report_date, :date
    add_column :claims, :liability_property_police_officer_first_name, :string
    add_column :claims, :liability_property_police_officer_last_name, :string
    add_column :claims, :liability_is_claim_against_municipality, :boolean
    add_column :claims, :liability_description_of_incident, :text
    add_column :claims, :liability_claim_details, :text
    add_column :claims, :liability_personal_injury_first_name_of_injured_person, :string
    add_column :claims, :liability_personal_injury_last_name_of_injured_person, :string
    add_column :claims, :liability_personal_injury_age_of_injured_person, :string
    add_column :claims, :liability_personal_injury_details, :text
    add_column :claims, :liability_personal_injury_address_of_injured_person, :string
    add_column :claims, :liability_personal_injury_place_of_occurrence, :string
    add_column :claims, :liability_personal_injury_date_of_occurrence, :date
  end
end
