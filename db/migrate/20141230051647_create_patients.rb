class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|

      t.string :name, null: false, default: 'Guest', limit: 100
      t.string :gender, null: false, default: 'Guest', limit: 20
      t.date :dob
      t.text :address
      t.string :pincode, null: false, default: 'Guest', limit: 20
      t.string :ext_uid, null: false, default: 'Guest', limit: 20

      t.timestamps
    end
  end
end
