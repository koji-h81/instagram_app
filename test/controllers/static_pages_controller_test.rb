require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "should get search" do
    get static_pages_search_url
    assert_response :success
  end

  test "should get notice" do
    get static_pages_notice_url
    assert_response :success
  end

  test "should get mypage" do
    get static_pages_mypage_url
    assert_response :success
  end

  test "should get upload" do
    get static_pages_upload_url
    assert_response :success
  end

end
