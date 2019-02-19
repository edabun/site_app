require 'test_helper'

class UserTest < ActiveSupport::TestCase
 
  def setup
    @user = User.new(name: "Jose Rizal", email: "jose_rizal@email.com",
    	             password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "name should be maximum of 50" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 255
    assert_not @user.valid?
  end

  test "emeil should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "email should be save as lowercase" do
    mixed_email = "Foo@ExaMPLE.com"
    @user.email = mixed_email
    @user.save
    assert_equal mixed_email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should be more than 5 characters" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "associated sites should be destroyed" do
    @user.save
    @user.sites.create!(name: "http://loremipsum.com")
    assert_difference 'Site.count', -1 do
      @user.destroy
    end
  end
end
