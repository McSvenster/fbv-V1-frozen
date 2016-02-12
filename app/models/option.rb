# encoding: UTF-8
class Option < ActiveRecord::Base
  validates_presence_of :date, :slots

end
