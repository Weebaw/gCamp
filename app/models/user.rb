class User < ActiveRecord::Base

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  has_secure_password

  has_many :projects, through: :memberships

  has_many :memberships, dependent: :destroy

  has_many :comments

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def membership(project)
    self.memberships.find_by(project_id: project.id) !=nil
  end

  def membership_owner(project)
    self.memberships.find_by(project_id: project.id).role == "Owner" || self.admin
  end

  def membership_member(project)
    self.memberships.find_by(project_id: project.id).role == "Member" || self.admin
  end

end
