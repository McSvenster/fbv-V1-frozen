# encoding: UTF-8
class Booking < ActiveRecord::Base

  belongs_to :company
  belongs_to :deliveryoption

  validates_presence_of :lwohnort, :birthdate, :lsdate, :vname, :nname, :ddate
  validates :ddate, uniqueness: {:message => :already_registered, scope: [:vname, :nname, :ddate]}
  validate :zeitlAblauf

  def zeitlAblauf
      if self.ddate != nil && self.ddate != "" && self.ddate > Time.now
        errors.add(:ddate, :future)
      end
      if self.bdate != nil && self.bdate != "" && self.ddate != nil && self.ddate != "" && self.bdate < self.ddate + 48.hours
        if self.btime != nil
          if self.btime.strftime("%H:%M") < self.ddate.strftime("%H:%M")
            errors.add(:bdate, :twodays)
          end
        elsif self.bdate < self.ddate + 24.hours
          errors.add(:bdate, :twodays)
        end
      end
      if self.lsdate != nil && self.lsdate != "" && self.bdate != nil && self.bdate != "" && self.lsdate.to_date > self.bdate
        errors.add(:lsdate, :before_bdate)
      end
      if self.lsdate != nil && self.lsdate != "" && self.bdate != nil && self.bdate != "" && self.lsdate.to_date == self.bdate
        if self.lsdate.strftime("%H:%M").to_time > "10:00".to_time
          errors.add(:lsdate, :eq_bdate)
        end
        if self.lseqb > 4
          errors.add(:lsdate, :to_many)
        end
      end
      if self.lsdate != nil && self.lsdate != "" && self.ddate != nil && self.ddate != "" && self.lsdate < self.ddate
        errors.add(:lsdate, :before_ddate)
      end
      if self.wludate != nil && self.wludate != "" && self.bdate != nil && self.bdate != "" && self.wludate <= (self.bdate.to_datetime) + 1.days + 9.hours + 59.minutes && self.approved != true
        errors.add(:wludate, :wlu_on_bdate)
      end
      if self.wludate != nil && self.wludate != "" && self.bdate != nil && self.bdate != "" && self.wludate < (self.bdate.to_datetime)
        errors.add(:wludate, :wlu_before_bdate)
      end
      if self.ddate != nil && self.ddate != "" && self.birthdate != nil && self.birthdate != "" && self.birthdate > self.ddate
        errors.add(:birthdate, :before_ddate)
      end
  end

  def lseqb
    Booking.where("lsdate >= ?", self.bdate).size
  end

end