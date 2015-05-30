require 'test_helper'

class RmasControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test 'should get manage' do
    get :manage
    assert_response :success
  end

end
