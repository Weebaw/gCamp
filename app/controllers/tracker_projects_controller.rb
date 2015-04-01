class TrackerProjectsController < PrivateController

  def show
    tracker_api = TrackerAPI.new
    if current_user.pivotaltoken
      @stories = tracker_api.stories(current_user.pivotaltoken, params[:id])
      @project = params[:name]
    end
  end

end
