class Sweepstake < ActiveRecord::Base
  has_attached_file :prize_image
  has_attached_file :rules
  validates_attachment_content_type :prize_image, :content_type => ["image/jpg", "image/jpeg", "image/png","image/gif","image/bmp"]
  validates_attachment_content_type :rules, :content_type => ["application/pdf","application/vnd.ms-excel",
                                                              "application/msword", 
                                                              "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
                                                              "text/plain"]
  # do_not_validate_attachment_file_type :prize_image
  # do_not_validate_attachment_file_type :rules
  # validates_attachment_content_type :prize_image, content_type: /\Aimage\/.*\Z/
  # validates_attachment_content_type :rules, content_type: /\Aimage\/.*\Z/
  
  has_many :participants
  has_many :winners
  belongs_to :admin_user
  has_one :winner
  has_one :entry_option

  def self.search(search)
   if search
     where('sweepstake_name LIKE ? or id LIKE ?', "%#{search}%","%#{search}%")
   else
     all
   end
 end
end
