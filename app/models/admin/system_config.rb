class Admin::SystemConfig

  require 'yaml'

  class << self
    attr_accessor :internal_price, :external_price, :new_request_mails, :new_deposit_slip_mail,
                  :return_page, :mail_request_auth

    def get
      config = YAML.load_file('config/system_config.yml')
      self.return_page = config['link_page']['return_page']
      self.mail_request_auth = config['mail_authorization']['mail_request_auth']
    end

   def update(params)
      config = YAML.load_file('config/system_config.yml')
      config['link_page']['return_page'] = params[:return_page] if params[:return_page]
      config['mail_authorization']['mail_request_auth'] = params[:mail_request_auth] if params[:mail_request_auth]
      File.open('config/system_config.yml','w') {|f| f.write config.to_yaml}
   end
  end

end
