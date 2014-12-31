class Patient < ActiveRecord::Base
	belongs_to :user
	has_many :studies
	validate_presence_of :comment
end
