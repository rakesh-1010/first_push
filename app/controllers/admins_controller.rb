class AdminsController < ApplicationController
  
  layout 'admin'
  
  def edit
    @admin_user = AdminUser.find(params[:id])
  end
  
  def update
    # Find an existing object using form parameters
    @admin_user =  AdminUser.find(params[:id])
    # Update the object
    if @admin_user.update_attributes(admin_user_params)
      # If update succeeds, redirect to the index actionflash[:succes] = 'Bang on!!! Is your name “PHOTOGENIC”?'
      flash[:success] = 'Bang on!!! Is your name “PHOTOGENIC”?'
      redirect_to edit_admin_path
    else
      # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end
  
  private
  
  def admin_user_params
    if params[:admin_user].present?
      params.require(:admin_user).permit(:avatar).merge(name: params[:name] , mobile_number: params[:mobile_number])
    else
      params.permit(:name, :mobile_number)
    end
  end
end
