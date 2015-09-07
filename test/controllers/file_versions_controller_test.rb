require 'test_helper'

class FileVersionsControllerTest < ActionController::TestCase
  setup do
    @file_version = file_versions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:file_versions)
  end

  test "should create file_version" do
    assert_difference('FileVersion.count') do
      path = Rails.root.join('public', "filemanagement")
      filename = "test.jpg"
      bin = File.open(path + filename, "rb")
      post :create, versioned_file_id: @file_version.versioned_file_id, file:bin
    end

    assert_response 201
  end

  test "should show file_version" do
    get :show, id: @file_version
    assert_response :success
  end

  test "should update file_version" do
    put :update, id: @file_version, file_version: { isActive: @file_version.isActive, path: @file_version.path, versioned_file_id: @file_version.versioned_file_id }
    assert_response 204
  end

  test "should destroy file_version" do
    assert_difference('FileVersion.count', -1) do
      delete :destroy, id: @file_version
    end

    assert_response 204
  end
end
