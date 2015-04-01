require 'rails_helper'

feature 'Existing users CRUD users' do

  before :each do
    User.destroy_all
    Project.destroy_all
    user = create_user(admin: true)
  end

  scenario "index lists all projects" do

    sign_in_user
    expect(current_path).to eq projects_path

  end

  scenario "can make a new project from the new project form" do

    sign_in_user
    visit (projects_path)
    within(".dropdown") do
      click_on 'New Project'
    end

    expect(current_path).to eq new_project_path

    fill_in :project_name, with: 'dig'

    click_button 'Create Project'

    expect(page).to have_content 'dig'
  end

  scenario "index links to show via the name" do

    sign_in_user
    user = create_user
    project = create_project
    membership = create_membership
    visit project_path(project)

    expect(page).to have_content 'Make Pocket Dog'
  end

  scenario "can edit user" do

    bam = Project.new(name: 'bam')
    bam.save!

    sign_in_user
    visit projects_path

    click_link "bam"
    click_link "Edit"

    fill_in :project_name, with: "bam!"

    click_button 'Update Project'

    expect(page).to have_content "Project was successfully updated"
    expect(page).to have_content 'bam!'
  end

  scenario "can delete project from index" do

    bam = Project.new(name: 'bam')
    bam.save!

    sign_in_user
    visit projects_path

    click_on "bam"

    within(".well") do
      click_on "Delete"
    end

    expect(page).to have_content "Project was successfully deleted"
    expect(page).not_to have_content "Jon"
  end

end
