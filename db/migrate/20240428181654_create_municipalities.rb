class CreateMunicipalities < ActiveRecord::Migration[7.1]
  def change
    create_table :municipalities, id: :uuid do |t|
      t.belongs_to :account, null: false, foreign_key: true, type: :bigint
      t.string :name
      t.boolean :is_active

      t.timestamps
    end
  end
end
