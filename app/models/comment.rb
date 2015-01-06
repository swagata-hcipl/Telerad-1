class Comment < ActiveRecord::Base
	belongs_to :study
	belongs_to :patient
	belongs_to :user
	validates_presence_of :comment
end
