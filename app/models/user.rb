class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_many :projects, through: :memberships

  has_many :memberships, dependent: :destroy

  # has_many :tasks, through: :comments, dependent: :destroy

  has_many :comments

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

end
