require 'test_helper'

class Admin::SystemConfigsControllerTest < ActionController::TestCase
  setup do
    @admin_system_config = admin_system_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_system_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_system_config" do
    assert_difference('Admin::SystemConfig.count') do
      post :create, admin_system_config: {  }
    end

    assert_redirected_to admin_system_config_path(assigns(:admin_system_config))
  end

  test "should show admin_system_config" do
    get :show, id: @admin_system_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_system_config
    assert_response :success
  end

  test "should update admin_system_config" do
    patch :update, id: @admin_system_config, admin_system_config: {  }
    assert_redirected_to admin_system_config_path(assigns(:admin_system_config))
  end

  test "should destroy admin_system_config" do
    assert_difference('Admin::SystemConfig.count', -1) do
      delete :destroy, id: @admin_system_config
    end

    assert_redirected_to admin_system_configs_path
  end
end
