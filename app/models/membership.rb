class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, uniqueness: {scope: :project_id, message: 'has already been added to this project'}
  validates :user, presence: true


  ROLE = ['Member', 'Owner']
end
