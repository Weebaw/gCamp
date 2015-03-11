cdrequire 'rails_helper'

  feature "sign-out" do

  before :each do
    User.destroy_all
  end

    scenario 'user can sign out' do


      sign_in_user

      expect(page).to have_content "George Clinton"

      click_on "Sign Out"

      expect(page).to have_content "Sign In"
      expect(current_path).to eq sign_out_path
      expect(page).to have_content "You have successfully logged out"
end
end
