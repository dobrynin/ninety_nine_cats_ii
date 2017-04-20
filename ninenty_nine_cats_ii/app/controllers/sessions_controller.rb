class SessionsController < ApplicationController
  before_action :redirect_user, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if user
      user.reset_session_token!
      login_user!(user)
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      redirect_to root_url
    end
  end
end
