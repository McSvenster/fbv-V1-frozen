# encoding: UTF-8
class User < ActiveRecord::Base

  attr_accessor :passwd_upd
  after_initialize :set_initial_password

  before_validation :downcase_email
  VALID_EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  has_secure_password
  belongs_to :company
  # accepts_nested_attributes_for :bookings

  validates_presence_of :email, :company_id, :vname, :nname, :tel
  validates :email, uniqueness: true, format: {with: VALID_EMAIL_REGEX }

  def full_name
    "#{vname} #{nname}"
  end

  def is_admin
    self.role == 1 || self.role == 2
  end

  def ist_bestatter?
    self.role == 3
  end

  def set_initial_password
    unless self.password_digest
      passwd = SecureRandom.hex
      self.password = passwd
      self.password_confirmation = passwd
    end
  end

  def downcase_email
    self.email = email.downcase if self.email.present?
  end

  def set_onetimetoken
    self.onetimetoken = SecureRandom.hex
    self.save(validate: false)
  end

  def reset_onetimetoken
    self.onetimetoken = nil
    self.save(validate: false)
  end

  scope :bestatter,-> {where(role: 3)}

end
