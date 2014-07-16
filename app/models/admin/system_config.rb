class Admin::SystemConfig

  require 'yaml'

  class << self
    attr_accessor :internal_price, :external_price, :new_request_mails, :new_deposit_slip_mail

    def get
      config = YAML.load_file('config/system_config.yml')
      self.internal_price = config['prices']['internal']
      self.external_price = config['prices']['external'] 
      self.new_request_mails = config['notifications']['new_request_mails']
      self.new_deposit_slip_mail = config['notifications']['new_deposit_slip_mail']
    end

   def update(params)
      config = YAML.load_file('config/system_config.yml')
      config['prices']['internal'] = params[:internal_price].to_i if params[:internal_price]
      config['prices']['external'] = params[:external_price].to_i if params[:external_price]
      config['notifications']['new_request_mails'] = params[:new_request_mails] if params[:new_request_mails] 
      config['notifications']['new_deposit_slip_mail'] = params[:new_deposit_slip_mail] if params[:new_deposit_slip_mail] 
      File.open('config/system_config.yml','w') {|f| f.write config.to_yaml}
   end
  end

end
