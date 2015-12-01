class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners do |t|
      t.integer :sweepstake_id
      t.integer :participant_id
      t.integer :admin_user_id

      t.timestamps null: false
    end
  end
end
