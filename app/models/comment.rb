class Comment < ApplicationRecord
	validates :description , presence: true, length: { minimum:4, maximum:140}
	
	belongs_to :user
	belongs_to :bug

	default_scope -> {order(created_at: :desc)}
end
