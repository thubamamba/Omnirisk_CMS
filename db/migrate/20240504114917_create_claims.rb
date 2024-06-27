class CreateClaims < ActiveRecord::Migration[7.1]
  def change
    create_table :claims, id: :uuid do |t|
      t.references :municipality, null: false, foreign_key: true, type: :uuid
      t.string :status
      t.string :claim_number
      t.string :claim_type
      t.string :type_of_property_loss
      t.datetime :date_of_loss
      t.string :police_ref_number
      t.string :police_station_incident_reported_to
      t.string :nature_of_incident
      t.string :insured_property_ownership
      t.text :description_of_incident
      t.string :incident_location
      t.boolean :is_active, default: true
      
      t.timestamps
    end
  end
end
