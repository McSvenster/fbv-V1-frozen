class CreateDeliveryoptions < ActiveRecord::Migration
  def change
    create_table :deliveryoptions do |t|
      t.string :deloption

      t.timestamps null: false
    end
  end
end
