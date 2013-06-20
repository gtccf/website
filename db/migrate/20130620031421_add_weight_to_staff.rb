class AddWeightToStaff < ActiveRecord::Migration
  def change
    add_column :staffs, :weight, :integer, default: 0
  end
end
