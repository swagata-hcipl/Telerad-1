class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.belongs_to :patient, index: true
      t.belongs_to :user, index: true

      t.string :study_uid
      t.string :num_instances
      
      t.timestamps
    end
  end
end
