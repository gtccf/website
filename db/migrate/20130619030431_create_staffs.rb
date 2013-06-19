class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :title
      t.string :email
      t.text :about

      t.timestamps
    end
  end
end
