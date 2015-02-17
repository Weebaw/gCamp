class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was successfully created"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to @user
    flash[:notice] = "User was successfully updated"
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to user_path, notice: "User was successfully deleted"
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end


end
