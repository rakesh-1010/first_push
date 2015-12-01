class ClientMailer < ApplicationMailer
	def sign_up_confirmation(client)
		@client = client
		@name = @client.name
		@url  = 'http://example.com/login'
		Rails.logger.info("=================mailer=================")
		Rails.logger.info(@winner.inspect)
		mail(to: @client.email, subject: 'Sign Up Confirmation')
	end
end
