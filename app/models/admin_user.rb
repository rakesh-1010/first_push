class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :set_role, :send_admin_mail
 
  has_many :sweepstakes
  has_many :participants
  has_many :winners
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x130>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  
  module Roles
    ADMIN = 'admin'
    CLIENT = 'client'
    ALL = [ADMIN, CLIENT]
  end
  
  def set_role
    self.update_attributes(:role => AdminUser::Roles::CLIENT)
  end
  
  def send_admin_mail
    ClientMailer.sign_up_confirmation(self).deliver
  end 
  
end
