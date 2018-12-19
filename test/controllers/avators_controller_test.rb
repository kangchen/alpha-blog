require 'test_helper'

class AvatorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @avator = avators(:one)
  end

  test "should get index" do
    get avators_url
    assert_response :success
  end

  test "should get new" do
    get new_avator_url
    assert_response :success
  end

  test "should create avator" do
    assert_difference('Avator.count') do
      post avators_url, params: { avator: { uid: @avator.uid } }
    end

    assert_redirected_to avator_url(Avator.last)
  end

  test "should show avator" do
    get avator_url(@avator)
    assert_response :success
  end

  test "should get edit" do
    get edit_avator_url(@avator)
    assert_response :success
  end

  test "should update avator" do
    patch avator_url(@avator), params: { avator: { uid: @avator.uid } }
    assert_redirected_to avator_url(@avator)
  end

  test "should destroy avator" do
    assert_difference('Avator.count', -1) do
      delete avator_url(@avator)
    end

    assert_redirected_to avators_url
  end
end
