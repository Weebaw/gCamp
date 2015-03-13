require 'rails_helper'

feature 'Existing users CRUD task' do

  before :each do
    User.destroy_all
    Task.destroy_all
    Project.destroy_all
  end

  scenario "can create a task" do
    project = Project.create!(name: 'school')

    sign_in_user
    expect(current_path).to eq root_path

    create_task

    expect(current_path).to eq project_tasks_path(project)
  end


  scenario "Project show page lists tasks" do
    project = Project.create!(name: 'school')

    sign_in_user
    expect(current_path).to eq root_path

    visit projects_path
    expect(page).to have_content "Projects"

    click_on "school"
    expect(page).to have_content "school"

    expect(page).to have_content "0 Tasks"

    click_on "0 Tasks"
    expect(page).to have_content "Tasks for school"

    click_on "New Task"
    fill_in :task_description, with: "homework"

    click_on "Create Task"

    click_on "New Task"
    fill_in :task_description, with: "study"

    click_on "Create Task"

    expect(page).to have_content "study"
    expect(current_path).to eq project_tasks_path(project)
end



  scenario "index links to show via the description" do

    project = Project.create!(name: 'school')

    sign_in_user
    expect(current_path).to eq root_path

    visit projects_path
    expect(page).to have_content "Projects"

    click_on "school"
    expect(page).to have_content "school"

    expect(page).to have_content "0 Tasks"

    click_on "0 Tasks"
    expect(page).to have_content "Tasks for school"

    click_on "New Task"
    fill_in :task_description, with: "homework"

    click_on "Create Task"

    click_on "homework"
    within ".page-header" do
      expect(page).to have_content "homework"
    end
  end

  scenario "can edit task" do


    project = Project.create!(name: 'school')

    sign_in_user
    expect(current_path).to eq root_path

    visit projects_path
    expect(page).to have_content "Projects"

    click_on "school"
    expect(page).to have_content "school"

    expect(page).to have_content "0 Tasks"

    click_on "0 Tasks"
    expect(page).to have_content "Tasks for school"

    click_on "New Task"
    fill_in :task_description, with: "homework"

    click_on "Create Task"

    expect(page).to have_content "Edit"

    click_on "Edit"

    fill_in :task_description, with: "errand"
    click_button 'Update Task'

    expect(page).to have_content "Task was successfully updated"
    expect(page).to have_content 'errand'
  end

  scenario "can delete task from index" do

    project = Project.create!(name: 'school')

    sign_in_user
    expect(current_path).to eq root_path

    visit projects_path
    expect(page).to have_content "Projects"

    click_on "school"
    expect(page).to have_content "school"

    expect(page).to have_content "0 Tasks"

    click_on "0 Tasks"
    expect(page).to have_content "Tasks for school"

    click_on "New Task"
    fill_in :task_description, with: "homework"

    click_on "Create Task"

    page.find('.glyphicon-remove').click

    expect(page).to have_content "Task was successfully deleted"
    expect(page).not_to have_content "homework"
  end
end
