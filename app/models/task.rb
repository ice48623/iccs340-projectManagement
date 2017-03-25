class Task < ApplicationRecord
  belongs_to :project
  has_many :task_comments
end
