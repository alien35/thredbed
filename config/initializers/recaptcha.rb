Recaptcha.configure do |config|
  config.public_key  = '6Le0bCUTAAAAAIUfpBcB3mZTnOnCwzsyLY-6-1q7'
  config.private_key = ENV['RECAPTCHA_SECRET_KEY']
end
