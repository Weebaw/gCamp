class AuthenticationController < ApplicationController

  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end

end
