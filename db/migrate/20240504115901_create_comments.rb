class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments, id: :uuid do |t|
      t.references :claim, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :bigint
      t.text :description
      t.boolean :is_verified
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
