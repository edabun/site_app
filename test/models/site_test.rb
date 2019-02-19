require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @site = @user.sites.build(name: "https://mysite.com")
  end

  test "should be valid" do
    assert @site.valid?
  end

  test "user id should be present" do
    @site.user_id = nil
    assert_not @site.valid?
  end

  test "site name should be present" do
    @site.name = nil
    assert_not @site.valid?
  end

  test "site name should be at most 140 characters" do
    @site.name = "a" * 141
    assert_not @site.valid?
  end

  test "order should be most recent first" do
    assert_equal sites(:most_recent), Site.first
  end
end
