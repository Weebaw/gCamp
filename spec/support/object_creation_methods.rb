def sign_in_user(user)
  visit sign_in_path
  fill_in :email, with: user.email
  fill_in :password, with: 'password'
  click_button 'Sign in'
end

def create_project(options = {})
  defaults = {
    name: "Make Pocket Dog"
  }
  project = Project.create!(defaults.merge(options))
end

def create_task(options={})
  Task.create!({
    description: "Put dog in pocket",
    project_id: create_project.id,
    due_date: "1/31/2015"
  }.merge(options))
end

def create_user(options={})
  User.create!({
    first_name: "Dirty",
    last_name: "Randy",
    email: "DirtyRandySeed#{rand(100000) + 1}@example.com",
    password: "password",
    password_confirmation: "password",
    admin: true
  }.merge(options))
end

def create_comment(options={})
  Comment.create!({
    content: "Pocket Dog?",
    user_id: create_user.id,
    task_id: create_task.id
  }.merge(options))
end

def create_membership(project, user, role="Owner")
  Membership.create!({
    role: role,
    project_id: project.id,
    user_id: user.id
  })
end
