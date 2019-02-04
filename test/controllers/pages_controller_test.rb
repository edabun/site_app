require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_path
    assert_response :success
    assert "title", "Home | Site App"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert "title", "About | Site App"
  end
end
