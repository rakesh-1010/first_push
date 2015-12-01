module SweepstakesHelper
  def generate_secure_key
    secure_key = SecureRandom.hex(3) 
    until !(Sweepstake.exists?(:p => p)) do
      p = SecureRandom.hex(3)
    end
    return secure_key
  end
  
  # def sweepstake_status(sweepstake)
  #   if sweepstake.status == "pending"
  #     return "Pending"
  #   elsif sweepstake.status == "approved"
  #     return "Approved"
  #   end
  # end
  
  def get_entry_option(sweepstake)
    return EntryOption.find( sweepstake.entry_option_id).entry_option_name
  end
  
  def sweepstake_status(sweepstake)
    if sweepstake.status == "pending"
      return button_tag "Pending", class: "btn btn-xs btn-warning"
    elsif sweepstake.status == "approved"
      return button_tag "Approved",class: "btn btn-xs btn-success"
    elsif sweepstake.status == "rejected"
      return button_tag "Rejected",class: "btn btn-xs btn-danger"
    elsif sweepstake.status == "new"
      return button_tag "New",class: "btn btn-xs btn-default"
    elsif sweepstake.status == "edited"
      return button_tag "Edited",class: "btn btn-xs btn-danger"
    end  

  end

  def admin_user_email(sweepstake)
    admin_user_email = AdminUser.find(sweepstake).email
  end
end
