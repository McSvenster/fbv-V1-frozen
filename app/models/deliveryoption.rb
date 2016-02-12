# encoding: UTF-8
class Deliveryoption < ActiveRecord::Base
  has_many :bookings
end
