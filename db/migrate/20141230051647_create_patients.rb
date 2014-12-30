class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.references :user

      t.string :name, null: false, default: 'Guest', limit: 100
      t.string :gender, null: false, default: 'Guest', limit: 20
      t.string :dob, null: false, default: 'Guest', limit: 20
      t.text :address, null: false, default: 'Guest', limit: 20
      t.string :pincode, null: false, default: 'Guest', limit: 20
      t.string :ext_uid, null: false, default: 'Guest', limit: 20

      t.timestamps
    end
  end
end
