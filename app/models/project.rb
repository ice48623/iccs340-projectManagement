class Project < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  belongs_to :team
  has_many :tasks
end
