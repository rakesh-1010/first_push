class CreateEntryOptions < ActiveRecord::Migration
  def change
    create_table :entry_options do |t|
      t.string :entry_option_name
      t.timestamps null: false
    end
  end
end
