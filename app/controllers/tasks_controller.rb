class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    task_params = params.require(:task).permit(:description)
    @task = Task.new(task_params)
    @task.save
    redirect_to task_path(@task), notice: "Task was successfully created"
  end

  def show
    @task = task.find_params([:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    task_params = params.require(:task).permit(:description)
    @product.update(task_params)
    redirect_to tasks_path, notice: "Task was successfully updated"
  end

end
