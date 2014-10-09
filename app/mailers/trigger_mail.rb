class TriggerMail < ActionMailer::Base
  default from: 'from@example.com'

  def welcome_email(mailer)
    mail(to: mailer, subject: 'Testing email')
  end
end