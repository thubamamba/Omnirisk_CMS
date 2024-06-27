class RemoveUnsusedDeetsFromClaims < ActiveRecord::Migration[7.1]
  def change
    remove_column :claims, :liability_registered_owner_first_name, :string
    remove_column :claims, :liability_registered_owner_last_name, :string
    remove_column :claims, :liability_registered_owner_email, :string
    remove_column :claims, :liability_registered_owner_contact_number, :string
    remove_column :claims, :liability_registered_owner_address, :string
  end
end
