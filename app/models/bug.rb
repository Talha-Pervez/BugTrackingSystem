class Bug < ApplicationRecord
  mount_uploader :screenshot, ScreenshotUploader

  enum bug_type:{feature: 'feature', bug: 'bug'}
  enum bug_status: {New: 'new', started: 'started', completed: 'completed', resolved: 'resolved'}
  
  validates :title, presence: true,
    uniqueness: { scope: :project,
                  message: 'Title must be unique within the scope of a project' 
                }
  validates :bug_type, presence: true
  validates :bug_status, presence:true

  has_many :comments, dependent: :destroy 
  
  belongs_to :project
  belongs_to :developer, class_name: 'User', foreign_key: 'developer_id'
  belongs_to :qa, class_name: 'User', foreign_key: 'qa_id'
end
