class AddPaymentDetailsToClaims < ActiveRecord::Migration[7.1]
  def change
    add_column :claims, :bank_details_bank_name, :string
    add_column :claims, :bank_details_branch_code, :string
    add_column :claims, :bank_details_account_holder_name, :string
    add_column :claims, :bank_details_account_number, :string
  end
end
