require 'test_helper'

class LightboxesControllerTest < ActionController::TestCase
  setup do
    @lightbox = lightboxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lightboxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lightbox" do
    assert_difference('Lightbox.count') do
      post :create, lightbox: { description: @lightbox.description, exampleimage: @lightbox.exampleimage, istockid: @lightbox.istockid, name: @lightbox.name, photographer_id: @lightbox.photographer_id }
    end

    assert_redirected_to lightbox_path(assigns(:lightbox))
  end

  test "should show lightbox" do
    get :show, id: @lightbox
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lightbox
    assert_response :success
  end

  test "should update lightbox" do
    patch :update, id: @lightbox, lightbox: { description: @lightbox.description, exampleimage: @lightbox.exampleimage, istockid: @lightbox.istockid, name: @lightbox.name, photographer_id: @lightbox.photographer_id }
    assert_redirected_to lightbox_path(assigns(:lightbox))
  end

  test "should destroy lightbox" do
    assert_difference('Lightbox.count', -1) do
      delete :destroy, id: @lightbox
    end

    assert_redirected_to lightboxes_path
  end
end
