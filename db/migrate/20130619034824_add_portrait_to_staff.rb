class AddPortraitToStaff < ActiveRecord::Migration
  def change
    add_column :staffs, :portrait, :string
  end
end
