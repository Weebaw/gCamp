require 'rails_helper'

  describe UsersController do

    before :each do
      @user = create_user(admin: false)
      session[:user_id]= @user.id
    end



    describe "#index" do

      it "allows admin users" do
         user = create_user(admin: true)
         session[:user_id] = user.id
         get :index
         expect(response).to be_success
      end


      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end

      it "does not display index for non_authenticated_users" do
        session.clear
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end

    describe "#new" do
      it "creates a new user" do
      get :new
      expect(response).to render_template :new
      expect(assigns(:user)).to be_a_new(User)
      end
    end

    describe "#create" do
      it "creates a new user when given valid params" do
        expect {
          post :create, user:{
            first_name: "Tom",
            last_name: "Jones",
            email: "tom@jones.com",
            password: 'jones',
            password_confirmation: "jones",
            admin: false
          }
        }.to change {User.all.count}.by(1)

        expect(flash[:notice]).to eq("User was successfully created")
      end
    end

    describe '#show' do
      it "displays user show page"do
        get :show, id: @user
        expect(assigns(:user)).to eq(@user)
        expect(response).to render_template :show
      end


      it "does not display page for non_authenticated_users" do
        session.clear
        get :show, id: @user
        expect(response).to redirect_to sign_in_path
      end
    end

    describe "#edit" do
      it "displays edit for the current user" do
      get :edit, id: @user
      expect(assigns(:user)).to eq(@user)
      expect(response).to render_template :edit
    end

      it "does not display page for non_authenticated_users" do
        session.clear
        get :edit, id: @user
        expect(response).to redirect_to sign_in_path
      end
    end

    describe "#update" do
      it "updates a user when given valid params" do
        expect {
          patch :update, id: @user, user:{
            first_name: "Joe",
            last_name: "Smith",
            email: "joe@smith.com",
            password: 'jones',
            password_confirmation: "jones",
            admin: false
          }
        }.to change {User.all.count}.by(0)

        user = User.last
        expect(user.first_name).to eq "Joe"
        expect(user.last_name).to eq "Smith"
        expect(user.email).to eq "joe@smith.com"

        expect(flash[:notice]).to eq("User was successfully updated")
      end


      it "doesn't update if user isn't authenticated" do
      user = create_user(email: "something@different.com")

      expect{
        patch :update, id: user, user: {
          first_name: user.first_name,
          last_name: "Nope",
          email: user.email,
          password: user.password,
          password_confirmation: user.password}
      }.to_not change{@user.reload.last_name}
      end
    end

    describe "#destroy" do
      it 'deletes a user and all their comments' do
        comment = create_comment(user_id: @user.id)

        expect{
          delete :destroy, id: @user.id
        }.to change {User.all.count}.by(-1)

        expect(response).to redirect_to "/"
        expect(flash[:notice]).to eq("User was successfully deleted")
      end

      it 'does not allow a non_admin to delete another user' do
        user = create_user

        expect{
          delete :destroy, id: user.id
        }.to_not change{User.all.count}
      end
    end
  end
