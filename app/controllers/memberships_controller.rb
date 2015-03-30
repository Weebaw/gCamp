class MembershipsController < PrivateController
  helper_method :owner_count
  helper_method :ensure_last_owner
  # helper_method :membership_owner
  before_action do
    @project = Project.find(params[:project_id])
  end
  # before_action do
  #   @membership = Membership.find(params[:id])
  # end
  before_action :logged_in_users_without_access, only: [:edit, :update, :destroy]
  before_action :verify_membership, except: [:new, :create, :index]
  before_action :verify_owner, only: [:edit]
  before_action :ensure_last_owner, only: [:update, :destroy]



  def index
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
        flash[:notice] = "#{@membership.user.full_name} was successfully added"
      redirect_to project_memberships_path(@project.id)
    else
      render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(membership_params)
      flash[:notice] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path(@project.id)
    else
      render :index
    end
  end

  def destroy
    membership = Membership.find(params[:id])
    membership.destroy
    flash[:notice] = "#{membership.user.full_name} was successfully removed"
    redirect_to projects_path
  end

private

  def logged_in_users_without_access
    if !current_user.memberships.pluck(:project_id).include?(@project.id)
      flash[:error] = "You do not have access"
      redirect_to project_path(@project)
    end
  end

  def membership_params
    params.require(:membership).permit(:role, :user_id, :project_id)
  end

  def owner_count
    @project.memberships.where(:role => "Owner").count
  end

  def ensure_last_owner
    membership = @project.memberships.find(params[:id])
    if membership.present?
      if owner_count <= 1 && membership.role == "Owner"
        flash[:error] = "Projects must have at least one owner"
        redirect_to project_memberships_path(@project)
      end
    end
  end
end
