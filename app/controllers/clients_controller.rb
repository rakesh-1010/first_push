class ClientsController < ApplicationController
  
  before_action :authenticate_admin_user!
  
  layout 'admin'
  
  def new
    Rails.logger.info("*********************************#{current_admin_user.inspect}")
    @client = Client.new
  end

  def create
    client = Client.new(client_params)
    client.admin_user_id = current_admin_user.id
    Rails.logger.info("*********************************#{current_admin_user.id}")
    if client.save!
      admin_user = AdminUser.find(current_admin_user.id)
      admin_user.update_attributes(:client_id => client.id)
      flash[:success] = 'Data Saved' 
      redirect_to new_client_path
    else
      flash[:danger] = 'Data not saved'
      render 'new'
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    client = Client.find(params[:id])
    if client.update_attributes(client_params)
      flash[:success] = 'Data updated' 
      redirect_to new_client_path
    else
      flash[:danger] = 'Data not saved'
      render 'new'
    end
  end
  
  private
    def client_params
      params.require(:client).permit(:organisation_name , :address , :city , :state , :country , :zipcode , 
                                       :landline_number , :mobile_number)
    end
end
