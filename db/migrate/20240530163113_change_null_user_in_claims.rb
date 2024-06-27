class ChangeNullUserInClaims < ActiveRecord::Migration[7.1]
  def change
    change_column_null :claims, :user_id, false
  end
end
