# encoding: utf-8
class Catalogs::Course < ActiveRecord::Base
  # validates_uniqueness_of :login
  validates_presence_of :name, :start_date

  def self.search(search)
    if search
      where("translate(lower(name),'áéíóúàèìòù', 'aeiouaeiou') LIKE translate(lower(?),'áéíóúàèìòù', 'aeiouaeiou')", "%#{search}%")
    else
      all
    end
  end 
end
