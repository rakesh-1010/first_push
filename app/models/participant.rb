class Participant< ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :omniauthable, :omniauth_providers => [:facebook],
         :authentication_keys => [:email]
  
  belongs_to :sweepstake
  belongs_to :admin_user
  has_one :winner
  
  def self.from_omniauth(auth, extra_params)
    sweepstake = Sweepstake.where(:secure_key => extra_params["secure_key"]).first
    participant = Participant.where(:provider => auth.provider, :uid => auth.uid, :secure_key => extra_params["secure_key"]).first
    if auth.info.email.blank?
      return "blank_email"
    else
      if participant
        return participant
      else
        registered_participant = Participant.where(:email => auth.info.email, :secure_key => extra_params["secure_key"]).first
        if registered_participant
          return registered_participant
        else
          userkey = Participant.generate_userkey(auth.info.email, extra_params["secure_key"])
          participant = Participant.new(:email => auth.info.email,
                                     :participant_name => auth.info.name,
                                     :provider => auth.provider,
                                     :uid => auth.uid,
                                     :oauth_tocken => auth.credentials.token,
                                     :oauth_expires_at => Time.at(auth.credentials.expires_at),
                                     :secure_key => extra_params["secure_key"],
                                     :admin_user_id => sweepstake.admin_user_id,
                                     :sweepstake_id => sweepstake.id,
                                     :userkey => userkey)
          participant.save!
          participant 
        end
      end
    end
  end
  
  def self.to_csv
    CSV.generate do |csv|
      csv << ["Participant Name", "Mobile Number", "email", "Entry Time [DD-MM-YYYY]"] ## Header values of CSV
      all.each do |pcpt|
        csv << [pcpt.participant_name, pcpt.participant_number, pcpt.email, pcpt.created_at.strftime("%d-%m-%Y")]
      end
    end
  end
  
  def self.search(search)
   if search
     where('participant_name LIKE ? or id LIKE ?', "%#{search}%","%#{search}%")
   else
     all
   end
 end
 
 def self.generate_userkey(email, secure_key)
   return email + secure_key
 end
end
