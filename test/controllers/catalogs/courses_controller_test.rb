require 'test_helper'

class Catalogs::CoursesControllerTest < ActionController::TestCase
  setup do
    @catalogs_course = catalogs_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_course" do
    assert_difference('Catalogs::Course.count') do
      post :create, catalogs_course: { academic_data_required: @catalogs_course.academic_data_required, color_theme1: @catalogs_course.color_theme1, color_theme2: @catalogs_course.color_theme2, color_theme3: @catalogs_course.color_theme3, contact: @catalogs_course.contact, content_file: @catalogs_course.content_file, description: @catalogs_course.description, end_date_pub: @catalogs_course.end_date_pub, end_date_reg: @catalogs_course.end_date_reg, image_file1: @catalogs_course.image_file1, image_file2: @catalogs_course.image_file2, image_file3: @catalogs_course.image_file3, info_after_reg: @catalogs_course.info_after_reg, instructors: @catalogs_course.instructors, location: @catalogs_course.location, mail_notif_deposit: @catalogs_course.mail_notif_deposit, max_quota: @catalogs_course.max_quota, min_quota: @catalogs_course.min_quota, name: @catalogs_course.name, opt_field: @catalogs_course.opt_field, opt_field_title: @catalogs_course.opt_field_title, payment_methods: @catalogs_course.payment_methods, prerequisites: @catalogs_course.prerequisites, price1: @catalogs_course.price1, price2: @catalogs_course.price2, price3: @catalogs_course.price3, schedule: @catalogs_course.schedule, start_date_pub: @catalogs_course.start_date_pub, start_date_reg: @catalogs_course.start_date_reg, target: @catalogs_course.target, user_id: @catalogs_course.user_id }
    end

    assert_redirected_to catalogs_course_path(assigns(:catalogs_course))
  end

  test "should show catalogs_course" do
    get :show, id: @catalogs_course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catalogs_course
    assert_response :success
  end

  test "should update catalogs_course" do
    patch :update, id: @catalogs_course, catalogs_course: { academic_data_required: @catalogs_course.academic_data_required, color_theme1: @catalogs_course.color_theme1, color_theme2: @catalogs_course.color_theme2, color_theme3: @catalogs_course.color_theme3, contact: @catalogs_course.contact, content_file: @catalogs_course.content_file, description: @catalogs_course.description, end_date_pub: @catalogs_course.end_date_pub, end_date_reg: @catalogs_course.end_date_reg, image_file1: @catalogs_course.image_file1, image_file2: @catalogs_course.image_file2, image_file3: @catalogs_course.image_file3, info_after_reg: @catalogs_course.info_after_reg, instructors: @catalogs_course.instructors, location: @catalogs_course.location, mail_notif_deposit: @catalogs_course.mail_notif_deposit, max_quota: @catalogs_course.max_quota, min_quota: @catalogs_course.min_quota, name: @catalogs_course.name, opt_field: @catalogs_course.opt_field, opt_field_title: @catalogs_course.opt_field_title, payment_methods: @catalogs_course.payment_methods, prerequisites: @catalogs_course.prerequisites, price1: @catalogs_course.price1, price2: @catalogs_course.price2, price3: @catalogs_course.price3, schedule: @catalogs_course.schedule, start_date_pub: @catalogs_course.start_date_pub, start_date_reg: @catalogs_course.start_date_reg, target: @catalogs_course.target, user_id: @catalogs_course.user_id }
    assert_redirected_to catalogs_course_path(assigns(:catalogs_course))
  end

  test "should destroy catalogs_course" do
    assert_difference('Catalogs::Course.count', -1) do
      delete :destroy, id: @catalogs_course
    end

    assert_redirected_to catalogs_courses_path
  end
end
