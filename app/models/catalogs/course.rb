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

  #UPLOAD FILE. IMPORTANT add to _form view , form_for(@instance, :html => {:multipart => true})
  def upload_file(upload,filename)
    directory = "public/attachments"
    path = File.join(directory, filename)
    # write the file
    File.open(path, "wb") { |f| f.write(upload.tempfile.read) }
  end
end
