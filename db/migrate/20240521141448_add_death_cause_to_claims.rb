class AddDeathCauseToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :accident_and_health_death_claim_death_cause, :string
  end
end
