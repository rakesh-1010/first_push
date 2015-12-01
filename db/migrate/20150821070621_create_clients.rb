class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.belongs_to :admin_user
      t.string :organisation_name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :zipcode
      t.string :landline_number
      t.string :mobile_number
      t.timestamps null: false
    end
  end
end
