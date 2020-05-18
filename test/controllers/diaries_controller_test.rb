require 'test_helper'

class DiariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get diarys_index_url
    assert_response :success
  end

  test "should get show" do
    get diarys_show_url
    assert_response :success
  end

  test "should get edit" do
    get diarys_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get diarys_destroy_url
    assert_response :success
  end

  test "should get update" do
    get diarys_update_url
    assert_response :success
  end

end
