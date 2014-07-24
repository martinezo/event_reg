require 'test_helper'

class Public::EventsCoursesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get event_info" do
    get :event_info
    assert_response :success
  end

end
