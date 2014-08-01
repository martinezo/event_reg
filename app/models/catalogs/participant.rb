class Catalogs::Participant < ActiveRecord::Base
  belongs_to :course, :class_name => 'Catalogs::Course'

  attr_reader :complete_name, :pdf_reg_filename, :upload_file1_s, :upload_file2_s, :upload_file3_s

  validates :name, :surnames, presence: true
  validates :course_id, uniqueness: {scope: [:name, :surnames]}

  def upload_file1_s(filename = nil)
    file = filename || upload_file1
    if file.strip.empty?
      nil
    else
      "#{id}_upload_file1.#{file.sub(/.*\./,'')}"
    end
  end

  def upload_file2_s(filename = nil)
    file = filename || upload_file2
    if file.strip.empty?
      nil
    else
      "#{id}_upload_file2.#{file.sub(/.*\./,'')}"
    end
  end

  def upload_file3_s(filename = nil)
    file = filename || upload_file2
    if file.strip.empty?
      nil
    else
      "#{id}_upload_file3.#{file.sub(/.*\./,'')}"
    end
  end


  #UPLOAD FILE. IMPORTANT add to _form view , form_for(@instance, :html => {:multipart => true})
  def upload_file(upload,filename)
    directory = "public/attachments/"
    path = File.join(directory, filename)
    # write the file
    File.open(path, "wb") { |f| f.write(upload.tempfile.read) }
  end



  def pdf_reg_filename
    ('%06i' % id) + "_registration.pdf"
  end

  def self.search(search, course_id)
    if search
      where("course_id = ? AND (translate(lower(name || ' ' || surnames ),'áéíóúàèìòù', 'aeiouaeiou') LIKE translate(lower(?),'áéíóúàèìòù', 'aeiouaeiou')\
            OR translate(lower(mail),'áéíóúàèìòù', 'aeiouaeiou') LIKE translate(lower(?),'áéíóúàèìòù', 'aeiouaeiou'))",
            "#{course_id}","%#{search}%","%#{search}%")
    else
      where("course_id=?","#{course_id}")
    end
  end

  def complete_name
    "#{name} #{surnames}"
  end
end
