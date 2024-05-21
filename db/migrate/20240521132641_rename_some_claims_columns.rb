class RenameSomeClaimsColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :claims, :accident_and_health_death_claim_description_of_claimant_occupat, :accident_and_health_death_claim_about_claimant_occupation
    rename_column :claims, :accident_and_health_death_claim_any_other_factors_to_death_caus, :accident_and_health_death_claim_any_factors_to_death_cause
    rename_column :claims, :accident_and_health_disability_claim_is_person_permanently_disa, :accident_and_health_disability_claim_is_permanently_disabled
    rename_column :claims, :accident_and_health_disability_claim_was_person_on_duty_during_, :accident_and_health_disability_claim_was_person_on_duty
  end
end
