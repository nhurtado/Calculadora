require 'test_helper'

class GoldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gold = golds(:one)
  end

  test "should get index" do
    get golds_url
    assert_response :success
  end

  test "should get new" do
    get new_gold_url
    assert_response :success
  end

  test "should create gold" do
    assert_difference('Gold.count') do
      post golds_url, params: { gold: { date_v: @gold.date_v, value: @gold.value } }
    end

    assert_redirected_to gold_url(Gold.last)
  end

  test "should show gold" do
    get gold_url(@gold)
    assert_response :success
  end

  test "should get edit" do
    get edit_gold_url(@gold)
    assert_response :success
  end

  test "should update gold" do
    patch gold_url(@gold), params: { gold: { date_v: @gold.date_v, value: @gold.value } }
    assert_redirected_to gold_url(@gold)
  end

  test "should destroy gold" do
    assert_difference('Gold.count', -1) do
      delete gold_url(@gold)
    end

    assert_redirected_to golds_url
  end
end
