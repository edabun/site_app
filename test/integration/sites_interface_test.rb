require 'test_helper'

class SitesInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "sites interface" do
    log_in_as(@user)
    get root_path
    assert_select 'h1', @user.name
    assert_select 'a', text: "view my profile"
    # invalid submission
    assert_no_difference 'Site.count' do
      post sites_path, params: { site: { name: " "} }
    end
    assert_select 'div#error_explanation'
    # valid submission
    site_name = "http://website.com"
    assert_difference 'Site.count', 1 do
      post sites_path, params: { site: { name: site_name } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match site_name, response.body
    # delete site
    assert_select 'a', text: 'delete'
    first_site = @user.sites.paginate(page: 1).first
    assert_difference 'Site.count', -1 do
      delete site_path(first_site)
    end
    # Visit different user(no links)
      # for change
      # to allow admin to delete siites
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end

  test "site sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.sites.count}", response.body
    # check user with zero sites
    other_user = users(:malory)
    log_in_as(other_user)
    get root_path
    assert_match "0 sites", response.body
    other_user.sites.create!(name: "http://test.com")
    assert_match "#{other_user.sites.count}", response.body
  end
end
