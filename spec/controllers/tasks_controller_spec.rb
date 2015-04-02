require 'rails_helper'


describe TasksController do
  before :each do
    @user = create_user(admin: false)
    session[:user_id] = @user.id
    @project = create_project
    @task = create_task(project_id: @project.id)
    @membership = create_membership(@project, @user, role: "Member")

  end

  describe "#index" do
    it "displays task index page" do
      task = create_task
      get :index, project_id: @project.id
      expect(response).to render_template :index
    end
  end

  describe "#new" do
    it "renders the new page" do
      get :new, project_id: @project.id
      expect(response). to be_success
      expect(response). to render_template :new
    end
  end

  describe "#create" do
    it 'project members can add tasks to projects' do
      expect{
        post :create, task: {description: "Play Outside"}, project_id: @project.id
      }.to change{Task.all.count}.by(1)
    end

    it 'non-project members cannot add tasks to projects' do
      session.clear
      user = create_user(admin: false)
      session[:user_id] = user.id

      expect{
        post :create, task: {description: "Play Outside"}, project_id: @project.id
      }.to_not change{Task.all.count}

      expect(flash[:error]).to eq("You do not have access to that project")
    end
  end

  describe "#show" do
    it "displays the show page" do
      get :show, project_id: @project.id, id: @task.id
        expect(response).to render_template :show
    end
  end

  describe "#edit" do
    it "displays edit task page" do
      get :edit, project_id: @project.id, id: @task.id
      expect(response).to be_success
      expect(response).to render_template :edit
    end
  end

  describe "#update" do
    it "updaates the current task" do
      project = create_project(name: "Hungry")
      task = create_task(description: "Eat pocket dog", project_id: project.id)
      membership = Membership.create!(user_id: @user.id, project_id: project.id, role: "Owner")
      patch :update, project_id: project.id, id: task.id, task: {description: "Eat pocket dogs!"}
      task.reload

      expect(task.description).to eq("Eat pocket dogs!")
      expect(response).to redirect_to project_tasks_path
      expect(flash[:notice]).to eq "Task was successfully updated"
    end
  end

  describe "#destroy" do
    it "allows owners to delete a task" do
      project = create_project(name: "Hungry")
      task = create_task(description: "Eat pocket dog", project_id: project.id)
      membership = Membership.create!(user_id: @user.id, project_id: project.id, role: "Owner")

      expect{
        delete :destroy, project_id: project.id, id: task.id
      }.to change {Task.all.count}.by(-1)

      expect(response).to redirect_to project_tasks_path
      expect(flash[:notice]).to eq("Task was successfully deleted")
    end
  end

end
