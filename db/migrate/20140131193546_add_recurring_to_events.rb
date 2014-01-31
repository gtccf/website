class AddRecurringToEvents < ActiveRecord::Migration
  def change
    add_column :events, :recurring, :text
  end
end
