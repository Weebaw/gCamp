require 'rails_helper'

feature 'Existing users CRUD users' do

  before :each do
    User.destroy_all
  end

  scenario "index lists all users with name, and email" do

    sign_in_user
    expect(current_path).to eq projects_path

    visit users_path
    expect(page).to have_content "Users"
    expect(page).to have_content "George"
    expect(page).to have_content "Clinton"
    expect(page).to have_content "parliament@mothershipconnection.com"
  end

  scenario "can make a new user from the new user form" do

    sign_in_user
    visit (users_path)
    click_link 'New User'

    expect(current_path).to eq new_user_path

    fill_in :user_first_name, with: 'Jon'
    fill_in :user_last_name, with: 'Bon Jovi'
    fill_in :user_email, with: 'shotthroughtheheart@youretoolate.com'
    fill_in :user_password, with: 'livinonaprayer'
    fill_in :user_password_confirmation, with: 'livinonaprayer'


    click_button 'Create User'

    expect(page).to have_content 'shotthroughtheheart@youretoolate.com'
  end

  scenario "index links to show via the name" do

    sign_in_user
    visit users_path

    click_link 'George'

    expect(page).to have_content 'parliament@mothershipconnection.com'
  end

  scenario "can edit user" do

    sign_in_user
    visit users_path

    click_link "George"
    click_link "Edit"

    expect(page).to have_content "Edit User"

    fill_in :user_first_name, with: "George S."
    fill_in :user_password, with: "bringthafunk"
    fill_in :user_password_confirmation, with: "bringthafunk"
    click_button 'Update User'

    expect(page).to have_content "User was successfully updated"
    expect(page).to have_content 'George S.'
  end

  scenario "can delete user from index" do
    user = User.new(first_name: 'Jon',
    last_name: 'Bon Jovi',
    email: 'shotthroughtheheart@youretoolate.com',
    password: 'livinonaprayer',
    password_confirmation: 'livinonaprayer')
    user.save!

    sign_in_user
    visit users_path

    click_on "Jon"

    click_on "Edit"

    click_on "Delete"

    expect(page).to have_content "User was successfully deleted"
  end

end
