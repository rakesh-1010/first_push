class SweepstakesController < ApplicationController

  before_action :authenticate_admin_user!, :except => ['display','preview']
  
  helper_method :sort_column, :sort_direction
  
  layout 'admin', :except => ['display']

  def index
    @sweepstakes = get_sweepstake.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
  end
    
  def show
    @sweepstake = Sweepstake.find(params[:id])
  end
  
  def new
    @sweepstake = Sweepstake.new
  end
  
  def create
    @sweepstake = Sweepstake.new(sweepstake_params)
    @sweepstake.status = "new"
    @sweepstake.start_date = @sweepstake.start_date - 330.minutes
    @sweepstake.end_date = @sweepstake.end_date - 330.minutes     
    if @sweepstake.save!
      n = (@sweepstake.end_date.to_date - Date.today).to_i
      
      Delayed::Job.enqueue(MailingJob.new(@sweepstake), :run_at => (n-1).days.from_now)
    else
      flash[:danger] = 'Something’s not right, let us try again'
    end
    redirect_to sweepstake_path(:id => @sweepstake.id)
    # redirect_to themes_sweepstakes_path(:id => @sweepstake.id)
  end

  def edit
    @sweepstake = Sweepstake.find(params[:id])
  end

  def update
    # Find an existing object using form parameters
    @sweepstake = Sweepstake.find(params[:id])
    @sweepstake.update_attributes(:status =>"edited")
    if params[:sweepstake][:start_date] != @sweepstake.start_date
      @sweepstake.start_date = @sweepstake.start_date - 330.minutes
    end
    if params[:sweepstake][:end_date] != @sweepstake.end_date
      @sweepstake.end_date = @sweepstake.end_date - 330.minutes
    end
    # Update the object
    if @sweepstake.update_attributes(sweepstake_params)
      n = (@sweepstake.end_date.to_date - Date.today).to_i
      # If update succeeds, redirect to the index action
      flash[:success] = "Wicked!! You just don’t want to leave a stone unturned."
      Delayed::Job.enqueue(MailingJob.new(@sweepstake), :run_at => (n-1).days.from_now) unless @sweepstake.previous_changes["end_date"].nil?
      redirect_to themes_sweepstakes_path(:id => @sweepstake.id)
    else
      # If update fails, redisplay the form so user can fix problems
      flash[:danger] = "Something’s not right, let us try again."
      render('edit')
    end
  end

  def delete
   @sweepstake = Sweepstake.find(params[:id])
  end

  def destroy
    @sweepstake = Sweepstake.find(params[:id]).destroy
    flash[:danger] = "Agree, enough is enough. Visit us again for another sweepstakes."
    redirect_to(:action => 'index')
  end
  
  def display
    begin
      @sweepstake = Sweepstake.find_by(:secure_key => params[:secure_key])
      @sweep_status = "ready"
      if @sweepstake.start_date.to_time >= Time.now
        @sweep_status = "not_ready"
      end
      if @sweepstake.end_date.to_time <= Time.now
        @sweep_status = "expired"
      end
      render layout: "sweepstake"
    rescue Exception => e
      render :template => 'layouts/generic_error', :layout => false
    end
  end

  def submit_for_approval
    sweepstake = Sweepstake.find(params[:sweepstake_id])
    sweepstake.update_attributes(:status => "pending")
    redirect_to sweepstakes_path
  end

  def themes
    @sweepstake = Sweepstake.find(params[:id])
  end

  def theme_select
    @sweepstake = Sweepstake.find(params[:id])
    @sweepstake.theme = params[:theme]
    @sweepstake.save!
    redirect_to sweepstake_path(:id => @sweepstake.id)
    flash[:success] = 'Awesome!That is for sure gonna make your customers greedy'
  end

  def approve_sweepstake
    sweepstake = Sweepstake.find(params[:sweepstake_id])
    #call presemter method to generate secure_key
    secure_key = SweepstakePresenter.new.generate_secure_key
    sweepstake.update_attributes(:status => "approved", :sweepstake_link => "#{ENV["SWEEP_HOST"]}/display/#{secure_key}", :secure_key => "#{secure_key}")
    NotificationMailer.sweepstakes_approval_mail(sweepstake.admin_user.email , sweepstake.admin_user.name , sweepstake.sweepstake_link).deliver_now
    redirect_to sweepstakes_path
  end
  
  def reject_sweepstake
    @sweepstake = Sweepstake.find(params[:id])
    @sweepstake.update_attributes(:status => "rejected")
    NotificationMailer.sweepstakes_reject_mail(@sweepstake.admin_user.email, sweepstake.admin_user.name).deliver_now
    redirect_to sweepstakes_path
  end
  
  def email_link
    @sweepstake = Sweepstake.find_by(:sweepstake_link => params[:link])
  end
  
  def send_email_link
    @email = params[:email_address].split(",")
    link = params[:link]
    sweepstake = Sweepstake.find_by(:sweepstake_link => params[:link])
    @email.each do |email|
      NotificationMailer.delay.sweepstakes_link_share(link , email)
    end
    redirect_to sweepstake_path(:id => sweepstake.id)
  end
  
  def preview
    if current_admin_user
      @sweepstake = Sweepstake.find(params[:id])
    end
    render layout: "sweepstake"
  end
  
  private
  
  def sweepstake_params
    params.require(:sweepstake).permit(:admin_user_id, :sweepstake_name, :prize_name, :prize_image, :start_date, :end_date, :winner_count, :entry_option_id, :rules, :bg_color, :question,:theme)
  end
  
  def get_sweepstake
    if is_superadmin?
      return Sweepstake.all
    else
      return Sweepstake.where(:admin_user_id => current_admin_user.id)
    end
  end
  
  # Used to search table columwise
  def sort_column
   Sweepstake.column_names.include?(params[:sort]) ? params[:sort] : "sweepstake_name"
  end
 
  #Used to decide search order
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end