require 'rails-helper'

feature 'Existing users CRUD task' do
  scenario "index lists all tasks with description" do
    homework = Task.new(description: 'Homework')
    homework.save!
    errand = Task.new(description: 'run errands')
    errand.save!

    sign_in_user
    expect(current_path).to eq root_path

    visit tasks_path
    expect(page).to have_content "Listing Tasks"
    expect(page).to have_content ""
