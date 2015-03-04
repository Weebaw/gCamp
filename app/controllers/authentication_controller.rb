class AuthenticationController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully signed in"
      redirect_to "/"
    else
      @authentication_error = "Email/password combination is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have successfully logged out'
    render :new
  end

end
