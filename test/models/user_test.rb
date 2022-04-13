require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  setup do
    @user = User.new(email: "foobar@example.com", password: "foobar2", password_confirmation: "foobar2")
  end

  test "User is registered as Stripe Customer after creation" do
    @user.save
    assert @user.customer_id
  end

  test "User is registered as admin if my email" do 
    @user.email = "myemail@example.com"
    @user.save
    assert @user.email
  end
end
