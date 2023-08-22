class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  default_scope -> {order(updated_at: :desc)}
  
  belongs_to :manager, class_name: 'User'

  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :bugs, dependent: :destroy  
end
