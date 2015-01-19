class Study < ActiveRecord::Base
  belongs_to :patient
  belongs_to :user
  belongs_to :study_table, :foreign_key => :study_uid

  scope :last_updated, -> {
    order('updated_at DESC, created_at DESC').limit(1)
  }

  def to_jq_upload
    {
      "id" => self.id,
      "desc" => self.study_table.study_desc,
      "num_instances" => self.study_table.num_instances,
      "conductedOn" => self.study_table.study_datetime,
      "updatedOn" => read_attribute(:updated_at)
    }
  end
end
