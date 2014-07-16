class Admin::User < ActiveRecord::Base
  validates_uniqueness_of :login
  validates_presence_of :login, :name, :mail

  def self.search(search)
    if search
      where('login LIKE ? OR name LIKE ? OR mail LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      all
    end
  end  
 
end
