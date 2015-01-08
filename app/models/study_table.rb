class StudyTable < ActiveRecord::Base
	belongs_to :study, primary_key: :study_iuid
	self.table_name = "study"
	establish_connection :pacs_development
end
