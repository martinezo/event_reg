# encoding: utf-8
class Admin::User < ActiveRecord::Base
  validates_uniqueness_of :login
  validates_presence_of :login, :name, :mail

  ROLES = {'Administrador' => 1, 'Creador de cursos' => 2, 'Administrador de cursos' => 3}
  attr_reader :role_str

  def self.search(search)
    if search
      where("login LIKE ? OR translate(lower(name),'áéíóúàèìòù', 'aeiouaeiou') LIKE translate(lower(?),'áéíóúàèìòù', 'aeiouaeiou') OR mail LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  def role_str
    role.nil? ? '' : ROLES.key(role)
  end
 
end
