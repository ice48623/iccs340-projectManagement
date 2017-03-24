class Project < ApplicationRecord
  belongs_to :team
  belongs_to :users
end
