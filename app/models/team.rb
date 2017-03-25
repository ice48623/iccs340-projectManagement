class Team < ApplicationRecord
  # has_many :teams_users
  # has_many :users, through: :teams_users
  has_and_belongs_to_many :users
  has_one :project
end
