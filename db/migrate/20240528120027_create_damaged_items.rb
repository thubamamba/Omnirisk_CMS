class CreateDamagedItems < ActiveRecord::Migration[7.1]
  def change
    create_table :damaged_items, id: :uuid do |t|
      t.string :item_name
      t.string :serial_number
      t.string :estimated_value
      t.references :claim, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
