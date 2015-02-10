class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create

    @task = Task.new(task_params)
    if @task.save
    flash[:notice] = "Task was successfully created"
    redirect_to @task
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    task_params = params.require(:task).permit(:description)
    @task.update(task_params)
    redirect_to @task
  end

  def task_params
    params.require(:task).permit(:description)
  end

end
