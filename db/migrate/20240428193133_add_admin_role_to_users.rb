class AddAdminRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :admin_role, :integer
  end
end
