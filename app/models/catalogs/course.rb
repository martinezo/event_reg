# encoding: utf-8
class Catalogs::Course < ActiveRecord::Base
  require 'color_handler'
  include ColorHandler

  belongs_to :user, :class_name => 'Admin::User'
  has_many :participants, :class_name => 'Catalogs::Participant'

  validates :user_id, presence: true

  # validates_uniqueness_of :login
  validates_presence_of :name, :start_date, :description

  #Change sql function now() instead date() for postresql
  scope :publishable, -> {where('date() BETWEEN start_date_pub AND end_date_pub')}

  attr_reader :registrable, :num_participants, :num_participants_confirmed, :trimmed_name

  def trimmed_name
    (name.size < 85)? name : "#{name[0..85]}..."
  end

  def num_participants
    self.participants.count
  end

  def num_participants_confirmed
    self.participants.where(:confirmed => true).count
  end

  #TODO validate if user write directly the url in navigator
  def registrable
    ((start_date_reg.try(:beginning_of_day) || end_date_reg.try(:beginning_of_day))..
     (end_date_reg.try(:end_of_day) || start_date_reg.try(:end_of_day))).cover? Time.now
  end

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

  def color_theme_l(color,amount)
    case color
      when 1
        lighten_color color_theme1,amount
      when 2
        lighten_color color_theme2,amount
      when 3
        lighten_color color_theme3,amount
      else
        lighten_color '000000',nil
    end
  end


  def color_theme_d(color,amount)
    case color
      when 1
        darken_color color_theme1,amount
      when 2
        darken_color color_theme2,amount
      when 3
        darken_color color_theme3,amount
      else
        darken_color '000000',nil
    end
  end
end
