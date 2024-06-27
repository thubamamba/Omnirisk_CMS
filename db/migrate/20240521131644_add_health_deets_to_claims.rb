class AddHealthDeetsToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :accident_and_health_claim_type, :string
    add_column :claims, :accident_and_health_claimant_first_name, :string
    add_column :claims, :accident_and_health_claimant_last_name, :string
    add_column :claims, :accident_and_health_claimant_id_number, :string
    add_column :claims, :accident_and_health_claimant_occupation, :string
    add_column :claims, :accident_and_health_death_claim_claimant_first_name, :string
    add_column :claims, :accident_and_health_death_claim_claimant_last_name, :string
    add_column :claims, :accident_and_health_death_claim_claimant_employee_status, :string
    add_column :claims, :accident_and_health_death_claim_confirmation_of_form_accuracy, :string
    add_column :claims, :accident_and_health_death_claim_description_of_claimant_occupation, :text
    add_column :claims, :accident_and_health_death_claim_date_of_death, :date
    add_column :claims, :accident_and_health_death_claim_place_of_death, :string
    add_column :claims, :accident_and_health_death_claim_any_other_factors_to_death_cause, :string
    add_column :claims, :accident_and_health_disability_claim_accident_date, :date
    add_column :claims, :accident_and_health_disability_claim_accident_place, :string
    add_column :claims, :accident_and_health_disability_claim_saps_and_oar_case_no, :string
    add_column :claims, :accident_and_health_disability_claim_description_of_accident, :text
    add_column :claims, :accident_and_health_disability_claim_is_person_permanently_disabled, :boolean
    add_column :claims, :accident_and_health_disability_claim_was_person_on_duty_during_the_accident, :boolean
    add_column :claims, :accident_and_health_claim_attending_doctor_first_name, :string
    add_column :claims, :accident_and_health_claim_attending_doctor_last_name, :string
    add_column :claims, :accident_and_health_claim_attending_doctor_practice_number, :string
    add_column :claims, :accident_and_health_claim_attending_doctor_contact_number, :string
    add_column :claims, :accident_and_health_claim_attending_doctor_address, :string
    add_column :claims, :accident_and_health_tdd_claim_description_of_injuries, :text
  end
end
