require 'test_helper'

class PhotographersControllerTest < ActionController::TestCase
  setup do
    @photographer = photographers(:one)
    @update = {
      name: 'test name',
      description: 'blah blah',
      website: 'http://website.com',
      phone: '+23 456 7',
      email: 'test@email.test',
      istock_name: 'testmctesty',
      istock_userid: '893283832',
      city: 'Atlantis',
      country: 'The Past'
  }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photographers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photographer" do
    assert_difference('Photographer.count') do
      post :create, photographer: @update
#      post :create, photographer: { city: @photographer.city, country: @photographer.country, description: @photographer.description, email: @photographer.email, istock_name: @photographer.istock_name, istock_userid: @photographer.istock_userid, name: @photographer.name, password: @photographer.password, phone: @photographer.phone, website: @photographer.website }
    end

    assert_redirected_to photographer_path(assigns(:photographer))
  end

  test "should show photographer" do
    get :show, id: @photographer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @photographer
    assert_response :success
  end

  test "should update photographer" do
    patch :update, id: @photographer, photographer: @update
#    patch :update, id: @photographer, photographer: { city: @photographer.city, country: @photographer.country, description: @photographer.description, email: @photographer.email, istock_name: @photographer.istock_name, istock_userid: @photographer.istock_userid, name: @photographer.name, password: @photographer.password, phone: @photographer.phone, website: @photographer.website }
    assert_redirected_to photographer_path(assigns(:photographer))
  end

  test "should destroy photographer" do
    assert_difference('Photographer.count', -1) do
      delete :destroy, id: @photographer
    end

    assert_redirected_to photographers_path
  end
end
