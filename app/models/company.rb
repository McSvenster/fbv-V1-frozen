class Company < ActiveRecord::Base
  
  has_many :users
  has_many :bookings
  
  validates_presence_of :name, :strasse, :hnr, :plz, :ort, :tel, :email
end
