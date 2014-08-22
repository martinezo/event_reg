class Admin::SystemConfig

  require 'yaml'

  class << self
    attr_accessor :internal_price, :external_price, :new_request_mails, :new_deposit_slip_mail,
                  :page_return, :mail_request_auth

    def get
      config = YAML.load_file('config/system_config.yml')
      self.page_return = config['link_page']['page_return']
      self.mail_request_auth = config['mail_authorization']['mail_request_auth']
    end

   def update(params)
      config = YAML.load_file('config/system_config.yml')
      config['link_page']['page_return'] = params[:page_return] if params[:page_return]
      config['mail_authorization']['mail_request_auth'] = params[:mail_request_auth] if params[:mail_request_auth]
      File.open('config/system_config.yml','w') {|f| f.write config.to_yaml}
   end
  end

end
