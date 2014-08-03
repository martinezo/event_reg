#MAILER CONFIGURATION

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address => "correo.inb.unam.mx" ,
    :port => 25,
    :domain => "inb.unam.mx" ,
    :enable_starttls_auto => true
    #:authentication => :login,
    #:user_name => "xxxxxxx",
    #:password => "xxxxxxx"
}