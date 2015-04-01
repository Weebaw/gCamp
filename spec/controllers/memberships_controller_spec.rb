require 'rails_helper'

describe MembershipsController do
  before :each do
    @user = create_user(admin: false)
    session[:user_id] = @user.id
    @user_admin = create_user(email: "admin@admin.com", admin: true)
    session[:user_id] = @user_admin.id
    @project = create_project
    @membership = create_membership(user_id: @user.id, project_id: @project.id)
    session[:user_id] = @user.id
  end

  describe '#index' do
    it "displays the memberships index page" do
    membership = create_membership
    get :index, project_id: @project.id
    expect(response).to render_template :index

    end
  end

  describe "#create" do
    it "creates a new member" do
      session.clear
      @user_admin = create_user(first_name: "Peter", last_name: "Piper", email: "peppers@fordays.com", password: "pepper", password_confirmation: "pepper" )
      session[:user_id] = @user_admin.id
      @project = create_project
      membership = create_membership(user_id: @user_admin.id, project_id: @project.id, role: "Owner")
      @user = create_user(first_name: "Johnny", last_name: "Appleseed", email: "seeds@fordays.com", password: "seeds", password_confirmation: "seeds" )
      expect { post :create, project_id: @project.id, membership:{project_id: @project.id, user_id: @user.id, role: "member"}}.to change {Membership.count}.by(1)
      expect(response).to redirect_to project_memberships_path(@project)

      end


      it 'does not allow nonmembers to edit memberships' do
        session.clear
        project = create_project
        membership = create_membership(user_id: @user_admin.id, project_id: project.id, role: "Owner")
        expect { post :create, project_id: project.id, membership:{project_id: project.id, user_id: @user.id, roles: "Member"}}.to change {Membership.count}.by(0)
        expect(response).to redirect_to sign_in_path
      end
    end


    describe "#update" do
      it "allows owners and admins rights to update memberships" do
        @user_admin = create_user
        session[:user_id] = @user_admin.id
        @user = create_user
        session[:user_id] = @user.id
        project = create_project
        membership_admin = create_membership(user_id: @user_admin.id, project_id: project.id, role: "Owner")
        membership = create_membership(user_id: @user.id, project_id: project.id, role: "Member")
        patch :update, project_id: project.id, id: membership.id, membership: {role: "Owner"}
        expect(response).to redirect_to project_memberships_path(project)
      end
    end

    it 'does not allow nonmembers to update memberships' do
      session.clear
      @user = create_user
      session[:user_id] = @user.id
      project = create_project
      membership = create_membership(user_id: @user.id, project_id: project.id, role: "Owner")
      patch :update, project_id: project.id, id: membership.id, membership: {role: "Member"}
      expect(response).to redirect_to project_memberships_path(project)
    end

    describe "#destroy" do
      it "allows owners to delete a task" do
        @user_admin = create_user
        session[:user_id] = @user_admin.id
        @user = create_user
        session[:user_id] = @user.id
        project = create_project
        membership_admin = create_membership(user_id: @user_admin.id, project_id: project.id, role: "Owner")
        membership = create_membership(user_id: @user.id, project_id: project.id, role: "Member")

        expect{
          delete :destroy, project_id: project.id, id: membership.id
        }.to change {Membership.all.count}.by(-1)

        expect(response).to redirect_to projects_path
        expect(flash[:notice]).to eq("Dirty Randy was successfully removed")
      end
    end


end
