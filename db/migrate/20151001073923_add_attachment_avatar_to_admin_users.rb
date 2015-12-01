class AddAttachmentAvatarToAdminUsers < ActiveRecord::Migration
  def self.up
    change_table :admin_users do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :admin_users, :avatar
  end
end
