class Catalogs::Participant < ActiveRecord::Base
  belongs_to :course, :class_name => 'Catalogs::Course'
  belongs_to :state, :class_name => 'Catalogs::State', :foreign_key => :inv_state_id

  validates :name, :surnames, presence: true
  validates :course_id, uniqueness: {scope: [:name, :surnames]}

  attr_reader :complete_name, :pdf_reg_filename, :upload_file1_s, :upload_file2_s, :upload_file3_s

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
    file = filename || upload_file3
    if file.strip.empty?
      nil
    else
      "#{id}_upload_file3.#{file.sub(/.*\./,'')}"
    end
  end

  #UPLOAD FILE. IMPORTANT add to _form view , form_for(@instance, :html => {:multipart => true})
  def upload_file(upload,filename)
    directory = "public/attachments/participants/"
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

  def self.for_course(course_id)
    select(fields_for_course(course_id));
  end

  def self.fields_for_course(course_id)
    course = Catalogs::Course.find(course_id)
    fields = [:id, :created_at, :name, :surnames, :mail, :phone_numbers, :workplace ]
    # price
    fields << :price unless course.price1_desc.strip.empty?
    # academic data
    fields += [:bachelor_deg, :master_deg, :phd_deg] if course.academic_data_required
    # invoice data
    fields += [:invoice_required, :inv_name, :inv_rfc, :inv_address, :inv_city, :inv_municipality, :inv_state_id] unless course.price1_desc.strip.empty?
    # optional data
    fields << :opt_text unless course.opt_text.strip.empty?
    fields << :opt_str1 unless course.opt_str1.strip.empty?
    fields << :opt_str2 unless course.opt_str2.strip.empty?
    fields << :opt_bol1 unless course.opt_bol1.strip.empty?
    fields << :opt_bol2 unless course.opt_bol2.strip.empty?
    fields << :opt_sel unless course.opt_sel.strip.empty?
    # attached files
    fields << :upload_file1 unless course.upload_file1_desc.strip.empty?
    fields << :upload_file2 unless course.upload_file2_desc.strip.empty?
    fields << :upload_file3 unless course.upload_file3_desc.strip.empty?
    fields
  end

end
