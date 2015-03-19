class TasksController < ProjectsController
  before_action :ensure_current_user
  before_action do
    @project = Project.find(params[:project_id])
  end


  def index
    @tasks = @project.tasks
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Task was successfully created"
      redirect_to project_tasks_path(@project)
    else
      render :new
    end
  end

  def show
    @task = @project.tasks.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to project_tasks_path(@project, @task)
      flash[:notice] = "Task was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    task = @project.tasks.find(params[:id])
    task.destroy
    redirect_to project_tasks_path(@project), notice: "Task was successfully deleted"
  end

  private

  def task_params
    params.require(:task).permit(:description, :complete, :due_date, :project_id)
  end

  def ensure_current_user
    unless current_user
      flash[:error] = "You must sign in"
      redirect_to sign_in_path
    end
  end

end
