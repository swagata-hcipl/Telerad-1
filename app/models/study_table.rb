class StudyTable < ActiveRecord::Base
	belongs_to :study, foreign_key: :study_iuid
	self.table_name = "study"
	establish_connection "pacs_development"
	# self.table_name = "study"
end
