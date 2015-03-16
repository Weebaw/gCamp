namespace :cleanup do
  desc 'Removes all memberships where their users have already been deleted'
  task list: :environment do
    Membership.where.not(user_id: User.pluck(:id)).destroy_all
    puts "this"
  end

  desc "Removes all memberships where their projects have already been deleted"
  task list: :environment do
    Membership.where.not(project_id: Project.pluck(:id)).destroy_all
    puts "is"
  end

  desc "Removes all tasks where their projects have been deleted"
  task list: :environment do
    Task.where.not(project_id: Project.pluck(:id)).destroy_all
    puts "why"
  end

  desc "Removes all comments where their tasks have been deleted"
  task list: :environment do
    Comment.where.not(task_id: Task.pluck(:id)).destroy_all
    puts "we"
  end



  desc "Sets the user_id of comments to nil if their users have been deleted"
  task list: :environment do
    Comment.where.not(user_id: User.pluck(:id)).update_all(user_id: nil)
    puts "run"
  end

  desc "Removes any tasks with null project_id"
  task list: :environment do
    Task.where(project_id: nil).destroy_all
    puts "the"
  end

  desc "Removes any comments with a null task_id"
  task list: :environment do
    Comment.where(task_id: nil).destroy_all
    puts "tests,"
  end

  desc "Removes any memberships with a null project_id"
  task list: :environment do
    Membership.where(project_id: nil).destroy_all
    puts "diggity"
  end

  desc "Removes any memberships with a null task_id"
  task list: :environment do
    Membership.where(user_id: nil).destroy_all
    puts "dog-town"
  end
end
