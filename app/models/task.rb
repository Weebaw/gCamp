class Task < ActiveRecord::Base
  validates :description, presence: true

  belongs_to :projects

end
