class Comment < ActiveRecord::Base
	belongs_to :study
	belongs_to :patient
	belongs_to :user
	has_paper_trail
	validates_presence_of :comment
end
