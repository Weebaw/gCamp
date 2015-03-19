require "rails_helper"

feature "sign in" do

  before :each do
    User.destroy_all
  end

  scenario "can sign in" do

    user = User.new(first_name: 'Jon',
    last_name: 'Bon Jovi',
    email: 'shotthroughtheheart@youretoolate.com',
    password: 'livinonaprayer',
    password_confirmation: 'livinonaprayer')
    user.save!

    visit root_path
    click_on "Sign In"

    expect(page).to have_content "Sign into gCamp"


    fill_in 'Email', with: 'shotthroughtheheart@youretoolate.com'
    fill_in 'Password', with: 'livinonaprayer'

    click_on "Sign in"

    expect(current_path).to eq projects_path

end

scenario 'are redirected back to the sign in form and shown a flash error if no such user exists' do
  visit root_path
  click_on 'Sign In'

  expect(current_path).to eq sign_in_path
  expect(page).to have_content 'Sign into gCamp'

  fill_in :email, with: 'Randy@Newman.com'
  fill_in :password, with: 'singwithrandy'
  click_button 'Sign in'

  expect(current_path).to eq sign_in_path
  expect(page).to have_content 'Email/password combination is invalid'
  end
end
