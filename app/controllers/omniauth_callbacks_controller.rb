class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
      @participant = Participant.from_omniauth(request.env["omniauth.auth"], request.env["omniauth.params"])
      if @participant == "blank_email"
        flash[:danger] = "You are not qualified to enter sweepstakes"
        redirect_to "/display/#{request.env["omniauth.params"]["secure_key"]}"
      else
       # fb_share(@participant.oauth_tocken, @participant.secure_key)
        if @participant.persisted?
          sign_in_and_redirect @participant, :event => :authentication #this will throw if @user is not activated
          # set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          sign_out :participant
          redirect_to "/display/#{request.env["omniauth.params"]["secure_key"]}"
        end
      end
  end
  
  private
   # def fb_share(oauth_token, secure_key)
    #  sweepstake = Sweepstake.find_by_secure_key(secure_key)
     # @graph = Koala::Facebook::API.new(oauth_token)
     # begin
        #@graph.put_wall_post("Participate and get a chance to win cool prizes", {:name => "#{sweepstake.sweepstake_name}", :link => "#{sweepstake.sweepstake_link}", :picture => "127.0.0.1:3000/public/assets/basic_sel.png"}, "me")
       # @graph.put_wall_post("Participate and get a chance to win cool prizes", {:name => "#{sweepstake.sweepstake_name}", :link => "#{sweepstake.sweepstake_link}", :picture => "#{ENV["SWEEP_HOST"]}/assets/#{sweepstake.theme}_sel.png"}, "me")
     # rescue Koala::Facebook::APIError => e
      #rescue OAuthException
       # flash[:danger] = "Already Posted"
     # end
     # return
   # end
end
