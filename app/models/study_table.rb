class StudyTable < ActiveRecord::Base
	# self.abstract_class = true
	self.table_name = "study"
	establish_connection :pacs_development
	# self.table_name = "study"
end
