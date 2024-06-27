class AddUserRefToClaims < ActiveRecord::Migration[7.1]
  def change
    add_reference :claims, :user, null: true, foreign_key: true, type: :bigint
  end
end
