class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :strasse
      t.string :hnr
      t.string :plz
      t.string :ort
      t.string :tel
      t.string :email

      t.timestamps null: false
    end
  end
end
