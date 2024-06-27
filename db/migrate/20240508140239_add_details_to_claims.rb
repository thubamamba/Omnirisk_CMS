class AddDetailsToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :is_property_insured_elsewhere, :boolean
    add_column :claims, :have_you_suffered_previous_loss, :boolean
    add_column :claims, :has_other_party_interest, :boolean
    add_column :claims, :was_property_occupied_during_damage, :boolean
    add_column :claims, :property_loss_location, :text
    add_column :claims, :declaration_accepted_at, :datetime, precision: nil
    add_column :claims, :information_sharing_accepted_at, :datetime, precision: nil
  end
end
