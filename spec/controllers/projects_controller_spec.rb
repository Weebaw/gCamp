require 'rails_helper'

describe ProjectsController do
  before :each do
    @user = create_user(admin: false)
    session[:user_id] = @user.id
    @project = create_project
  end

  describe "#index" do
    it "assigns all projects with a title eat" do
      project = create_project(name: "eat")
      membership = Membership.create!(user_id: @user.id, project_id: project.id, role: "Owner")

      get :index

      expect(assigns(:projects)).to eq [project]
    end
  end

  describe "#new" do
    it "renders the new page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "#create" do

    describe "on success" do
      it "user can create a new project with valid parameters" do
        expect{
          post :create, project: {
            name: "Brovloski"
          }
        }.to change{Project.all.count}.by(1)

        project = Project.last
        expect(project.name).to eq "Brovloski"
        expect(flash[:notice]).to eq "Project was successfully created"
      end
    end
  end

    describe "#show" do
    it "displays the project show page" do
      get :show, id: @project
      expect(assigns(:project)).to eq(@project)
    end


  it "does not display page for non_authenticated_users" do
    session.clear
    get :show, id: @user
    expect(response).to redirect_to sign_in_path
    end
  end

  describe "#edit" do
    it "displays edit project page" do
      get :edit, id: @project.id
      expect(assigns(:project)).to eq(@project)
    end

    it "does not display page for non_authenticated_users" do
      session.clear
      get :edit, id: @project
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "can update a project with valid attributes" do
  it "project owner can update projects" do

    project = create_project(name: "Dog")
    membership = Membership.create!(user_id: @user.id, project_id: project.id, role: "Owner")
    expect {
      patch :update, id: project.id, project: {name: "Cat"}}.to change {project.reload.name}.from("Dog").to("Cat")

      expect(flash[:notice]).to eq "Project was successfully updated"
      expect(response).to redirect_to project_path(project)
    end
  end

  describe "#destroy" do
    it "owners can delete a project" do
      project = create_project
      membership = Membership.create!(user_id: @user.id, project_id: project.id, role: "Owner")
      task = create_task(project_id: @project.id)
      expect{
      delete :destroy, id: project.id
    }.to change {Project.all.count}.by(-1)

    expect(response).to redirect_to projects_path
    expect(flash[:notice]).to eq("Project was successfully deleted")

    end


  it "adminss can delete a project" do
    session.clear
    admin = create_user(admin: true)
    project = create_project
    membership = Membership.create!(user_id: @user.id, project_id: project.id, role: "Owner")
    task = create_task(project_id: @project.id)

    session[:user_id] = admin.id
    expect{
      delete :destroy, id: project.id
    }.to change {Project.all.count}.by(-1)

    expect(response).to redirect_to projects_path
    expect(flash[:notice]).to eq("Project was successfully deleted")

  end
end


end
