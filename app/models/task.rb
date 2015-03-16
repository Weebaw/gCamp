class Task < ActiveRecord::Base
  validates :description, presence: true

  belongs_to :projects

  has_many :comments, dependent: :destroy


end
