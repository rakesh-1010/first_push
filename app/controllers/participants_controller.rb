class ParticipantsController < ApplicationController
  
  before_action :authenticate_admin_user! , :except => ['register']
  
  layout 'admin', :except => ['display']
  
  def index
    @participants=get_participant.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
    respond_to do |format|
      format.html
      format.csv {send_data @participants.to_csv ,filename: "Participant_Report_#{Time.now}.csv"}
    end
  end
  
  def register
    begin
      sweepstake = Sweepstake.find_by secure_key: params[:key]
      if Participant.where(:email => participant_params[:email], :secure_key => params[:key]).empty?
        participant = sweepstake.participants.new(participant_params)
        puts "#{participant_params.inspect}"
        participant.sweepstake_id = sweepstake.id
        participant.admin_user_id = sweepstake.admin_user_id
        participant.userkey = Participant.generate_userkey(participant_params[:email], params[:key])
        participant.save
      end
      redirect_to "/display/#{sweepstake.secure_key}"
    # rescue Exception => e
    #   render :template => "layout/generic_error", :layout => false
    end
  end
  
  def delete
   @participant = Participant.find(params[:id])
  end

  def destroy
    @participant = Participant.find(params[:id]).destroy
    redirect_to participants_path
  end
  
  #list out participants according to sweepstakes
  def view_participant
    @sweepstake = Sweepstake.find(params[:id])
    @participants = Participant.where(:sweepstake_id => @sweepstake.id )
    @winner_count = Winner.where(:sweepstake_id => @sweepstake.id ).count
  end
  
  #used to generate winners randomly && called from view_participants page
  def random_winner
    @sweepstake = Sweepstake.find(params[:id])
    winner_count = Winner.where(:sweepstake_id => @sweepstake.id ).count
    if (Time.now > @sweepstake.end_date)
      participant = Participant.where(:sweepstake_id => @sweepstake.id)
      result_arr = Array.new    
      total_winner = @sweepstake.winner_count.to_i - winner_count
      result_arr = participant.sample(total_winner)
        result_arr.each do |result|
        winner= Winner.new(:sweepstake_id => result.sweepstake_id,:participant_id => result.id, :admin_user_id => result.admin_user_id)
        winner.save
        flash[:success] = 'It was a tough decision, glad I made the right choice.'
        view_winners_participants_path(:id=>@sweepstake.id)
      end
    else
      flash[:danger] = 'There is no early bird prize, the sweepstake is still on, let us wait.'
      view_participant_participants_path(:id=>@sweepstake.id)
    end
    @winner_record = Participant.joins(:winner).where(:sweepstake_id => @sweepstake.id)
  end
  
  
  #used to generate winners manually && called from view_participants page
  def manual_winner
    @sweepstake = Sweepstake.find(params[:sweepstake_id])
    if (Time.now > @sweepstake.end_date)
        #sweepstake_id = params[:sweepstake_id]
        participant_id = params[:participant_id]
        @winner = Winner.new(:sweepstake_id => @sweepstake.id,:participant_id => participant_id, :admin_user_id => @sweepstake.admin_user_id)
        if @winner.save
          flash[:success] = 'Wise decision, that looked like a winner from the very onset.'
          redirect_to view_participant_participants_path(:id => @sweepstake.id)
        else
          flash[:danger] = 'Aaarrghhhh…...but patience will pay dividends (for the eventual winner)'
        end
    else
      flash[:danger] = 'There is no early bird prize, the sweepstake is still on, let us wait.'
      redirect_to sweepstakes_path
    end
  end
  
  def view_winners
    @winner_record = Participant.joins(:winner).where(:sweepstake_id => params[:id])
    @sweepstake = Sweepstake.find(params[:id])
  end
  
  def email_winner
    @winner_record = Participant.joins(:winner).where(:sweepstake_id => params[:id])
    ParticipantMailer.winner_confirmation(@winner_record).deliver_now!
    flash[:success] = "Decision goes knocking"
    redirect_to sweepstakes_path
  end
  
  def all_winners
    @sweepstake = get_sweepstake
    sweepstake = @sweepstake.first
    @winner_record = Participant.joins(:winner).where(:sweepstake_id => sweepstake.id)
  end
  
  def winner_list
    
  end
  
  private

    def get_participant
      if is_superadmin?
        return Participant.all
      else
        return current_admin_user.participants
      end
    end
    
    def get_sweepstake
      if is_superadmin?
        return Sweepstake.all
      else
        return Sweepstake.where(:admin_user_id => current_admin_user.id)
      end
    end

    def participant_params
      params.require(:enroll).permit(:entry_option_id,:participant_name,:participant_number,:answer, :email, :secure_key, :current_sign_in_ip)
    end
end