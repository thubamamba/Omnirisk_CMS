class AddRegisteredOwnerDeetsToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :liability_motor_claim_registered_owner_first_name, :string
    add_column :claims, :liability_motor_claim_registered_owner_last_name, :string
    add_column :claims, :liability_motor_claim_registered_owner_email, :string
    add_column :claims, :liability_motor_claim_registered_owner_telephone_number, :string
    add_column :claims, :liability_motor_claim_registered_owner_physical_address, :string
  end
end
