class DashboardsController < ApplicationController
  
  before_action :authenticate_admin_user!
  before_action :get_data, :only => 'index'
  
  layout 'admin'
  
  def index
    
  end
  
  private

  def get_data
    if is_superadmin?
      @participants = Participant.all
      @sweepstakes = Sweepstake.all
      @winner = Winner.all
    else
      @participants = current_admin_user.participants
      @sweepstakes = current_admin_user.sweepstakes
      @winner = current_admin_user.winners
    end
  end
end
