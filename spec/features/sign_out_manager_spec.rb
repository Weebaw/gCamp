require 'rails_helper'

  feature "sign-out" do

  before :each do
    User.destroy_all
  end

    scenario 'user can sign out' do

      user = create_user
      sign_in_user(user)

      expect(page).to have_content "Dirty Randy"

      click_on "Sign Out"

      expect(page).to have_content "Sign In"
      expect(current_path).to eq sign_out_path
      expect(page).to have_content "You have successfully logged out"
end
end
