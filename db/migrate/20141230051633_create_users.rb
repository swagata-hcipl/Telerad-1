class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :gateway, null: false, default: 'Guest', limit: 20
      t.string :name, null: false, default: 'Guest', limit: 100
      t.text :address, null: false, default: 'Guest'
      t.string :gateway_type, null: false, default: 'Guest', limit: 20
      t.string :password_digest, null: false, default: 'Guest', limit: 200

      t.timestamps
    end
  end
end
