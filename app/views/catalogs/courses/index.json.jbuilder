json.array!(@catalogs_courses) do |catalogs_course|
  json.extract! catalogs_course, :id, :user_id, :name, :description, :schedule, :location, :content_file, :price1, :price2, :price3, :payment_methods, :target, :prerequisites, :min_quota, :max_quota, :instructors, :contact, :image_file1, :image_file2, :image_file3, :start_date_pub, :end_date_pub, :start_date_reg, :end_date_reg, :mail_notif_deposit, :academic_data_required, :info_after_reg, :color_theme1, :color_theme2, :color_theme3, :opt_field, :opt_field_title
  json.url catalogs_course_url(catalogs_course, format: :json)
end
