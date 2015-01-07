class Study < ActiveRecord::Base
	belongs_to :patient
	belongs_to :user
	belongs_to :study_table, :foreign_key => :study_uid

	def to_jq_upload
    {
      "id" => self.id,
      "desc" => self.study_table.study_desc,
      "num_instances" => read_attribute(:num_instances),
      "conductedOn" => self.study_table.study_datetime,
      "updatedOn" => read_attribute(:updated_at)
    }
  end
end
