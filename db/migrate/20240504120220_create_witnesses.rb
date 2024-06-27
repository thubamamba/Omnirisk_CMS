class CreateWitnesses < ActiveRecord::Migration[7.1]
  def change
    create_table :witnesses, id: :uuid do |t|
      t.references :claim, null: false, foreign_key: true, type: :uuid
      t.string :witness_prefix
      t.string :witness_name
      t.string :witness_contact_number
      t.string :witness_email
      t.string :witness_physical_address
      t.boolean :is_verified, default: true
      
      t.timestamps
    end
  end
end
