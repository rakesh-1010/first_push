class NotificationMailer < ApplicationMailer
	def notification(client_1)
		   @client_1 = client_1
		   @url  = 'http://example.com/login'
		   mail(to: @client_1, subject: 'Sweepstake-Notification')
	end

	def notification_end(client)
		@client = client
		@url  = 'http://example.com/login'
		mail(to: @client, subject: 'Sweepstake-Notification')
	end

	def sweepstake_end_email(sweepstake)
		@sweepstake = sweepstake
	   	mail(to: @sweepstake.admin_user.email, subject: 'Only 24 hrs Remaining for sweepstakes to end')
	end

  def sweepstakes_link_share(link, email)
    Rails.logger.info("**********************************************#{email}")
    @link = link
    mail(to: email, subject: 'Sweepstakes Invitation')
  end

  def sweepstakes_approval_mail(email, name, link)
    @name = name
    @link = link
    mail(to: email, subject: 'Sweepstakes Approved')
  end
  
  def sweepstakes_reject_mail(email, name)
    @name = name
    mail(to: email, subject: 'Sweepstakes Rejected')
  end

end
