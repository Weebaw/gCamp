class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :same_project

    def current_user
      @current_user = User.find_by_id(session[:user_id])
    end

    def verify_membership
      unless current_user.membership(@project) || current_user.admin == true
        flash[:error] = "You do not have access to that project"
        redirect_to projects_path
      end
    end

    def verify_owner
      unless current_user.membership_owner(@project) || current_user.admin == true
        flash[:error] = "You do not have access to that project"
        redirect_to projects_path(@project)
      end
    end

    def set_project
      @project = Project.find(params[:id])
    end

    def same_project(user1,user2)
      unless user2.projects.where(id: user1.projects) == []
        true
      end
    end

end
