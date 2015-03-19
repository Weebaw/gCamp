class CommentsController < PrivateController


  before_action do
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id])
  end

  def create
    comment = @task.comments.new(comment_params)
    comment.save
    redirect_to project_task_path(@project, @task)
  end


  private

  def comment_params
    params.require(:comment).permit(:content).merge(:user_id => current_user.id)
  end

end
