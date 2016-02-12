class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.date :date
      t.integer :slots
      t.integer :bdates

      t.timestamps null: false
    end
  end
end
