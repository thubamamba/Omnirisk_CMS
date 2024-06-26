class AddTrackableToDevise < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_ip, :string
    add_column :users, :sign_in_count, :integer, default: 0, null: false
  end
end
