class CreateSweepstakes < ActiveRecord::Migration
  def change
    create_table :sweepstakes do |t|
      t.belongs_to :admin_user
      t.string :sweepstake_name
      t.string :prize_name
      t.attachment :prize_image
      t.integer :winner_count
      t.integer :entry_option_id, array: true, default: []
      t.string :question
      t.datetime  :start_date
      t.datetime :end_date
      t.attachment :rules
      t.string :bg_color
      t.string :status
      t.string :sweepstake_link
      t.timestamps null: false
    end
  end
end
