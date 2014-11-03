class TriggerMail < ActionMailer::Base
  default from: 'no-reply@ciot.com'

  def trigger_activate(trigger)
  	@title = trigger.title
  	@property = trigger.property
  	@operation = trigger.operation
  	@value = trigger.value
  	@id = trigger.id
    mail(to: trigger.email, subject: trigger.message)
  end
end