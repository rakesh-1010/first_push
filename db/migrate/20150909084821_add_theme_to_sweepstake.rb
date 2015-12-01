class AddThemeToSweepstake < ActiveRecord::Migration
  def change
    add_column :sweepstakes, :theme, :string
  end
end
