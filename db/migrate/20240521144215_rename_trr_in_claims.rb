class RenameTrrInClaims < ActiveRecord::Migration[7.1]
  def change
    rename_column :claims, :accident_and_health_tdd_claim_description_of_injuries, :accident_and_health_ttd_claim_description_of_injuries
  end
end
