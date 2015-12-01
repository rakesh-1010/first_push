class AddOmniauthToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :provider, :string
    add_index :participants, :provider
    add_column :participants, :uid, :string
    add_index :participants, :uid
    add_column :participants, :oauth_tocken, :string
    add_column :participants, :oauth_expires_at, :datetime
  end
end
