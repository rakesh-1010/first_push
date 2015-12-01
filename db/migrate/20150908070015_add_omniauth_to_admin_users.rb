class AddOmniauthToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :provider, :string
    add_index :admin_users, :provider
    add_column :admin_users, :uid, :string
    add_index :admin_users, :uid
    add_column :admin_users, :oauth_tocken, :string
    add_column :admin_users, :oauth_expires_at, :datetime
  end
end
