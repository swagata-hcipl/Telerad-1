class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :study
      t.references :user
      t.text :comment

      t.timestamps
    end
  end
end
