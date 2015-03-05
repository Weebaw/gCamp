require 'rails_helper'

feature 'Existing users CRUD task' do

  before :each do
    User.destroy_all
    Task.destroy_all
  end

  scenario "index lists all tasks with description" do
    homework = Task.new(description: 'Homework')
    homework.save!
    errand = Task.new(description: 'errands')
    errand.save!

    sign_in_user
    expect(current_path).to eq root_path

    visit tasks_path
    expect(page).to have_content "Listing Tasks"
    expect(page).to have_content "Due Date"
    expect(page).to have_content "Homework"
    expect(page).to have_content "errands"
  end

  scenario "can make a new task from the new task form" do

    sign_in_user
    visit (tasks_path)
    click_link 'New Task'

    expect(current_path).to eq new_task_path

    fill_in :task_description, with: 'clean'
    click_button 'Create Task'

    expect(page).to have_content 'clean'
end

  scenario "index links to show via the description" do

    errands = Task.new(description: 'errands')
    errands.save!

    sign_in_user
    visit tasks_path

    click_link 'errands'

    expect(current_path).to eq task_path(errands)
    expect(page).to have_content "errands"
end
  scenario "can edit task" do

    errands = Task.new(description: 'errands')
    errands.save!

    sign_in_user
    visit tasks_path

    click_link "errands"
    click_link "Edit"

    expect(page).to have_content "Edit Task"

    fill_in :task_description, with: "errand"
    click_button 'Update Task'

    expect(page).to have_content "Task was successfully updated"
    expect(page).to have_content 'errand'
  end

  scenario "can delete task from index" do
    errands = Task.new(description: 'errands')
    errands.save!

    sign_in_user
    visit tasks_path

    click_on "Delete"

    expect(page).to have_content "Task was successfully deleted"
    expect(page).not_to have_content "errands"
  end

end
