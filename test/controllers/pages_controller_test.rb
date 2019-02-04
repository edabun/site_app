require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

  test "should get root" do
    get root_url
    assert_response :success
    assert "title", "Home | Site App"
  end

  test "should get home" do
    get pages_home_url
    assert_response :success
    assert "title", "Home | Site App"
  end

  test "should get about" do
    get pages_about_url
    assert_response :success
    assert "title", "About | Site App"
  end

end
