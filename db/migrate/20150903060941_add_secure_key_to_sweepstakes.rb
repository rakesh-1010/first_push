class AddSecureKeyToSweepstakes < ActiveRecord::Migration
  def change
    add_column :sweepstakes, :secure_key, :string
  end
end
