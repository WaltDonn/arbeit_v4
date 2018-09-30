class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    # logging user information for debugging purposes...
    logger.info(User.find_by_email(params[:email]).as_json)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    elsif user
      flash.now.alert = "Password invalid"
      render "new" 
    else
      flash.now.alert = "Email invalid"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end