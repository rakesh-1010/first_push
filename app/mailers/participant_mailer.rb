class ParticipantMailer < ApplicationMailer
  
 # default from: 'rajesh010794@gmail.com'

  def winner_confirmation(winner)
     @winner = winner
     @url  = 'http://example.com/login'
     Rails.logger.info("=================mailer=================")
     Rails.logger.info(@winner.inspect)
     @winner.each do |i|
       @name = i.participant_name
       Rails.logger.info("================#{i.email.inspect}==================")
       mail(to: i.email, subject: 'Congratulation')
    end
  end
end
