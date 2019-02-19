require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:michael)
    @user = users(:archer)
    @site = sites(:site_2)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Site.count' do
      post sites_path, params: { site: { name: "Sample Site" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Site.count' do
      delete site_path(@site)
    end
    assert_redirected_to login_url
  end

  test "should view sites even when not logged in" do
    get site_path(@site)
    assert_template 'sites/show'
  end

  # test "should view sites even as other user" do
  #   log_in_as(@user)
  #   get site_path(@site)
  #   assert_template 'sites/show'
  #   delete logout_path
  #   log_in_as(@admin_user)
  #   get site_path(@site)
  #   assert_template 'sites/show'
  # end

  test "should redirect destroy for wrong site" do
    log_in_as(users(:michael))
    site = sites(:one)
    assert_no_difference 'Site.count' do
      delete site_path(site)
    end
    assert_redirected_to root_url
  end
end
