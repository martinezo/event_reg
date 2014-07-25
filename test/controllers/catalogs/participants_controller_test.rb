require 'test_helper'

class Catalogs::ParticipantsControllerTest < ActionController::TestCase
  setup do
    @catalogs_participant = catalogs_participants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogs_participants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogs_participant" do
    assert_difference('Catalogs::Participant.count') do
      post :create, catalogs_participant: { bachelor_deg: @catalogs_participant.bachelor_deg, confirmed: @catalogs_participant.confirmed, course_id: @catalogs_participant.course_id, inv_address: @catalogs_participant.inv_address, inv_city: @catalogs_participant.inv_city, inv_email: @catalogs_participant.inv_email, inv_municipality: @catalogs_participant.inv_municipality, inv_name: @catalogs_participant.inv_name, inv_rfc: @catalogs_participant.inv_rfc, inv_state: @catalogs_participant.inv_state, mail: @catalogs_participant.mail, master_deg: @catalogs_participant.master_deg, name: @catalogs_participant.name, opt_bol1: @catalogs_participant.opt_bol1, opt_bol2: @catalogs_participant.opt_bol2, opt_sel: @catalogs_participant.opt_sel, opt_str1: @catalogs_participant.opt_str1, opt_str2: @catalogs_participant.opt_str2, opt_text: @catalogs_participant.opt_text, phd_deg: @catalogs_participant.phd_deg, phone_numbers: @catalogs_participant.phone_numbers, price: @catalogs_participant.price, str_op1: @catalogs_participant.str_op1, surnames: @catalogs_participant.surnames, workplace: @catalogs_participant.workplace }
    end

    assert_redirected_to catalogs_participant_path(assigns(:catalogs_participant))
  end

  test "should show catalogs_participant" do
    get :show, id: @catalogs_participant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catalogs_participant
    assert_response :success
  end

  test "should update catalogs_participant" do
    patch :update, id: @catalogs_participant, catalogs_participant: { bachelor_deg: @catalogs_participant.bachelor_deg, confirmed: @catalogs_participant.confirmed, course_id: @catalogs_participant.course_id, inv_address: @catalogs_participant.inv_address, inv_city: @catalogs_participant.inv_city, inv_email: @catalogs_participant.inv_email, inv_municipality: @catalogs_participant.inv_municipality, inv_name: @catalogs_participant.inv_name, inv_rfc: @catalogs_participant.inv_rfc, inv_state: @catalogs_participant.inv_state, mail: @catalogs_participant.mail, master_deg: @catalogs_participant.master_deg, name: @catalogs_participant.name, opt_bol1: @catalogs_participant.opt_bol1, opt_bol2: @catalogs_participant.opt_bol2, opt_sel: @catalogs_participant.opt_sel, opt_str1: @catalogs_participant.opt_str1, opt_str2: @catalogs_participant.opt_str2, opt_text: @catalogs_participant.opt_text, phd_deg: @catalogs_participant.phd_deg, phone_numbers: @catalogs_participant.phone_numbers, price: @catalogs_participant.price, str_op1: @catalogs_participant.str_op1, surnames: @catalogs_participant.surnames, workplace: @catalogs_participant.workplace }
    assert_redirected_to catalogs_participant_path(assigns(:catalogs_participant))
  end

  test "should destroy catalogs_participant" do
    assert_difference('Catalogs::Participant.count', -1) do
      delete :destroy, id: @catalogs_participant
    end

    assert_redirected_to catalogs_participants_path
  end
end
