class CreateSweepstakeParticipants < ActiveRecord::Migration
  def change
    create_table :sweepstake_participants do |t|
      t.belongs_to :sweepstake
      t.belongs_to :participant

      t.timestamps null: false
    end
  end
end
