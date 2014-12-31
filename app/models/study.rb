class Study < ActiveRecord::Base
	belongs_to :user
	belongs_to :patient
	has_many :comments
end
