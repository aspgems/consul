class ApplicationMailer < ActionMailer::Base
  helper :settings
  default from: Rails.configuration.consul['mailer_sender']
  layout 'mailer'
end
