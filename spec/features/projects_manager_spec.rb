require 'rails_helper'

feature 'Existing users CRUD users' do

  before :each do
    User.destroy_all
    Project.destroy_all
  end

  scenario "index lists all projects with name" do

    bam = Project.new(name: 'bam')
    bam.save!

    sign_in_user
    expect(current_path).to eq root_path

    visit projects_path
    expect(page).to have_content "bam"
  end

  scenario "can make a new project from the new project form" do

    sign_in_user
    visit (projects_path)
    click_link 'New Project'

    expect(current_path).to eq new_project_path

    fill_in :project_name, with: 'dig'

    click_button 'Create Project'

    expect(page).to have_content 'dig'
  end

  scenario "index links to show via the name" do

    bam = Project.new(name: 'bam')
    bam.save!

    sign_in_user
    visit projects_path

    click_link 'bam'

    expect(page).to have_content 'bam'
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

    click_on "Delete"

    expect(page).not_to have_content "Jon"
  end

end
