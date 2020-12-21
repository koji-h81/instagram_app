require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Instagram App"
  end

  test "should get mypage" do
    get mypage_path
    assert_response :success
    assert_select "title", "Mypage | Instagram App"
  end

  test "should get upload" do
    get upload_path
    assert_response :success
    assert_select "title", "Upload | Instagram App"
  end
  
  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Instagram App"
  end
  
  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | Instagram App"
  end
  
  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Instagram App"
  end
end
