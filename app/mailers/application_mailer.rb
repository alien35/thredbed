class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@comlink.com"
  layout 'mailer'
end
