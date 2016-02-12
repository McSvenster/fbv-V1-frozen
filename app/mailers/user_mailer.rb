class UserMailer < ApplicationMailer

  def password_reset(user)
    @user = user
    @url = "http://reserve-test.elasticbeanstalk.com/"
    mail(to: @user.email, subject: 'Passwort setzen')
  end
end
