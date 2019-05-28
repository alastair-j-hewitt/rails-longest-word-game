require 'test_helper'

class NewControllerTest < ActionDispatch::IntegrationTest
  test "should get new_game" do
    get new_new_game_url
    assert_response :success
  end

  test "should get score" do
    get new_score_url
    assert_response :success
  end

end
