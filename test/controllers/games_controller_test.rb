require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Use a tiny fixed dictionary so the tests do not depend on the machine's word list.
    GamesController.instance_variable_set(:@dictionary, Set.new(%w[CAT TACT]))
  end

  teardown do
    GamesController.instance_variable_set(:@dictionary, nil)
  end

  test "new shows a grid of ten letters" do
    get new_url
    assert_response :success
    assert_select "input[name=letters]" do |inputs|
      assert_equal 10, inputs.first["value"].split.size
    end
  end

  test "a valid word that fits the grid wins" do
    post score_url, params: { word: "cat", letters: "C A T X Y" }
    assert_match "Congratulations", response.body
  end

  test "a word needing a letter twice must have it twice in the grid" do
    post score_url, params: { word: "tact", letters: "T A C X Y" }
    assert_match "can&#39;t be built", response.body
  end

  test "a word that fits but is not English loses" do
    post score_url, params: { word: "act", letters: "A C T" }
    assert_match "not seem to be a valid English word", response.body
  end

  test "an empty word is rejected" do
    post score_url, params: { word: "", letters: "A B C" }
    assert_match "can&#39;t be built", response.body
  end
end
