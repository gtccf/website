class CreateDevotions < ActiveRecord::Migration
  def change
    create_table :devotions do |t|
      t.string :title
      t.date :release_date
      t.text :body

      t.timestamps
    end
  end
end
