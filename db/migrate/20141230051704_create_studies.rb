class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.references :user
      t.references :patient
      t.string :study_uid

      t.timestamps
    end
  end
end
