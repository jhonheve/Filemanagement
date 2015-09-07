require 'test_helper'

class VersionedFilesControllerTest < ActionController::TestCase
  setup do
    @versioned_file = versioned_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:versioned_files)
  end

  test "should create versioned_file" do
    assert_difference('VersionedFile.count') do
      post :create, versioned_file: { description: @versioned_file.description, name: @versioned_file.name }
    end

    assert_response 201
  end

  test "should show versioned_file" do
    get :show, id: @versioned_file
    assert_response :success
  end

  test "should update versioned_file" do
    put :update, id: @versioned_file, versioned_file: { description: @versioned_file.description, name: @versioned_file.name }
    assert_response 204
  end

  test "should destroy versioned_file" do
    assert_difference('VersionedFile.count', -1) do
      delete :destroy, id: @versioned_file
    end

    assert_response 204
  end
end
