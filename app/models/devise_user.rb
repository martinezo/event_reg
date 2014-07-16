class DeviseUser < ActiveRecord::Base
  self.table_name = 'admin_users'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable
  #,:registerable, :recoverable, :rememberable, :trackable, :validatable
end
