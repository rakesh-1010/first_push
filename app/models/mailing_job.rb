class MailingJob < Struct.new(:sweepstake)

	def perform
		Rails.logger.info("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
		NotificationMailer.sweepstake_end_email(sweepstake).deliver_now
	end

end