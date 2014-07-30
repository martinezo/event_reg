class Catalogs::Participant < ActiveRecord::Base
  belongs_to :course, :class_name => 'Catalogs::Course'

  attr_reader :complete_name

  validates :name, :surnames, presence: true
  validates :course_id, uniqueness: {scope: [:name, :surnames]}

  def self.search(search, course_id)
    if search
      where("course_id = ? AND (translate(lower(name),'áéíóúàèìòù', 'aeiouaeiou') LIKE translate(lower(?),'áéíóúàèìòù', 'aeiouaeiou')\
            OR translate(lower(surnames),'áéíóúàèìòù', 'aeiouaeiou') LIKE translate(lower(?),'áéíóúàèìòù', 'aeiouaeiou')\
            OR translate(lower(mail),'áéíóúàèìòù', 'aeiouaeiou') LIKE translate(lower(?),'áéíóúàèìòù', 'aeiouaeiou'))",
            "#{course_id}","%#{search}%","%#{search}%","%#{search}%")
    else
      where("course_id=?","#{course_id}")
    end
  end

  def complete_name
    "#{name} #{surnames}"
  end
end
