class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum signup_type: { manager: 'manager', qa: 'qa', developer: 'developer' }

  validates :name, presence: true
  validates :signup_type, presence: true

  has_many :created_projects, class_name: 'Project', foreign_key: 'manager_id'
  has_many :user_projects
  has_many :projects, through: :user_projects, dependent: :destroy
  has_many :assigned_bugs, class_name: 'Bug', foreign_key: 'developer_id'
  has_many :created_bugs, class_name: 'Bug', foreign_key: 'qa_id'
  has_many :comments, dependent: :destroy 
end
