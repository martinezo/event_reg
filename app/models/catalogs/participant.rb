class Catalogs::Participant < ActiveRecord::Base
  belongs_to :course, :class_name => 'Catalogs::Course'

  scope :of_course, -> (course_id) {where(:course_id => course_id)}
  
  attr_reader :complete_name

  def complete_name
    "#{name} #{surnames}"
  end
end
