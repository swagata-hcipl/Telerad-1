class Comment < ActiveRecord::Base
	belongs_to :study
	has_paper_trail
end
