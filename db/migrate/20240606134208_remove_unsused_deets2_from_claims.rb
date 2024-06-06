class RemoveUnsusedDeets2FromClaims < ActiveRecord::Migration[7.1]
  def change
    remove_column :claims, :liability_registered_owner_physical_address, :string
  end
end
