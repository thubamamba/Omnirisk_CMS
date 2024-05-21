class AddRegisteredOwnerPhysicalAddressToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :liability_registered_owner_physical_address, :string
  end
end
