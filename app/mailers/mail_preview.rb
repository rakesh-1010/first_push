class MailPreview < MailView

	def notify_mailer
		ClientMailer.sign_up_confirmation(AdminUser.first)
	end
end