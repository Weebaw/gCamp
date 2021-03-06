require 'rails_helper'

feature 'Existing users CRUD task' do

  before :each do
    User.destroy_all
    Task.destroy_all
    Project.destroy_all
    @user = create_user
    sign_in_user(@user)
    @project = Project.create!(name: 'school')
    membership = create_membership(@project, @user)


  end

  scenario "can create a task" do


    expect(current_path).to eq projects_path

    create_task

    expect(current_path).to eq projects_path
  end


  scenario "Project show page lists tasks" do

    expect(current_path).to eq projects_path

    visit projects_path
    expect(page).to have_content "Projects"

    within('.project_list') {click_link "school"}

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
    expect(current_path).to eq project_tasks_path(@project)
end



  scenario "index links to show via the description" do


    expect(current_path).to eq projects_path

    visit projects_path
    expect(page).to have_content "Projects"

    within('.project_list') {click_link "school"}
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



    expect(current_path).to eq projects_path

    visit projects_path
    expect(page).to have_content "Projects"

    within('.project_list') {click_link "school"}
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


    expect(current_path).to eq projects_path

    visit projects_path
    expect(page).to have_content "Projects"

    within('.project_list') {click_link "school"}
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
