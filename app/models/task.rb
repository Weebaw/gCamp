class Task < ActiveRecord::Base
  validates :description, presence: true

  belongs_to :projects

  has_many :comments, through: :users
  has_many :comments
  

end
