class Study < ActiveRecord::Base
	belongs_to :patient
	belongs_to :user
	belongs_to :study_table, :foreign_key => :study_uid

	def to_jq_upload
    {
      "id" => self.id,
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE"
    }
  end
end
