require 'test_helper'

class ClientControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get location" do
    get :location
    assert_response :success
  end

end
