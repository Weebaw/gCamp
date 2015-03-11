def sign_in_user
  user = User.new(first_name: 'George', last_name: 'Clinton', email: 'parliament@mothershipconnection.com', password: 'bringthafunk', password_confirmation: 'bringthafunk')
  user.save!
  visit sign_in_path
  fill_in :email, with: 'parliament@mothershipconnection.com'
  fill_in :password, with: 'bringthafunk'
  click_button 'Sign in'
end

def create_task
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
end
