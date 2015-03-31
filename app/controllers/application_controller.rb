class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user

    def current_user
      @current_user = User.find_by_id(session[:user_id])
    end

    def verify_membership
      unless current_user.membership(@project) || current_user.admin == true
        flash[:error] = " to that project"
        redirect_to projects_path
      end
    end

    def verify_owner
      unless current_user.membership_owner(@project) || current_user.admin == true
        flash[:error] = " to that project"
        redirect_to projects_path(@project)
      end
    end

    def set_project
      @project = Project.find(params[:id])
    end

end
