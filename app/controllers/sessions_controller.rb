class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username_and_password(
      params[:user][:username],
      params[:user][:password])

    if user
      sign_in(user)
      redirect_to tickets_url
    else
      flash.now[:errors] = ["Invalid username or password!"]
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end
end
