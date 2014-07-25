class Catalogs::Participant < ActiveRecord::Base
  belongs_to :course, :class_name => 'Catalogs::Course'

  scope :of_course, -> (course_id) {where(:course_id => course_id)}
end
