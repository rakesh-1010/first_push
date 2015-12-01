namespace :active_sweepstake do
  desc "TODO"																																																																																																																																																																																																																																																																																																																																																																																																																																																							
  task sweepstake_status_active: :environment do
 	
    @current_sweep =Sweepstake.joins(:admin_user).where(:end_date => Date.today+1 )
    @admin_user=Array.new
    puts "******#{@current_sweep.inspect}******"
    @current_sweep.each do |i|
    	puts "******#{i.admin_user_id}******"
    	@admin_user << i.admin_user_id

    	puts "run**********"
    end	
    puts "******#{@admin_user}******"
    for i in 0...@admin_user.count
    	@notify = AdminUser.find(@admin_user[i])
     	puts "****11**#{@notify.inspect}**11****"
    	NotificationMailer.notification(@notify.email).deliver
	 end
  end
end

  
