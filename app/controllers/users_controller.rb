class UsersController < PrivateController
  before_action :ensure_current_user
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :cant_edit, only: [:edit, :update, :destroy]

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
      redirect_to users_path
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
    if @user.update(user_params)
      redirect_to @user
      flash[:notice] = "User was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    if @user == current_user
      user.destroy
      redirect_to users_path
    else
      user.destroy
      redirect_to users_path, notice: "User was successfully deleted"
  end
end

  private

  def user_params
    if current_user.admin
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end


  def ensure_current_user
    unless current_user
      flash[:error] = "You must sign in"
      redirect_to sign_in_path
    end
  end

  def cant_edit
    unless current_user.admin
      if current_user != @user
        render file: 'public/404.html', status: :not_found, layout: false
      end
    end
  end

  def set_user
      @user = User.find(params[:id])
  end


end
