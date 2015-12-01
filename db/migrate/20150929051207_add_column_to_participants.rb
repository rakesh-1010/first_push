class AddColumnToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :admin_user_id, :integer
    add_column :participants, :sweepstake_id, :integer
  end
end
