class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :vname
      t.string :nname
      t.integer :company_id
      t.string :password_digest
      t.string :strasse
      t.string :hnr
      t.string :plz
      t.string :ort
      t.string :tel
      t.integer :role
      t.string :onetimetoken

      t.timestamps null: false
    end
  end
end
