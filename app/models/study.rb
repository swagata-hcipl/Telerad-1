class Study < ActiveRecord::Base
	belongs_to :patient
	belongs_to :user
	belongs_to :study_table, :foreign_key => :study_uid
end
