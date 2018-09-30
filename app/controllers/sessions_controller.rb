class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    # logging user information for debugging purposes...
    logger.info(User.find_by_email(params[:email]).as_json)
    # mimicking sql inj below
    if user && (user.authenticate(params[:password]) || params[:password].delete(' ').end_with?("\"OR\"1==1") || params[:password].delete(' ').end_with?("\"OR\"0==0") || params[:password].delete(' ').end_with?("\"OR\"2==2") || params[:password].delete(' ').end_with?("\"OR\"3==3") || params[:password].delete(' ').end_with?("\"OR\"TRUE"))
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