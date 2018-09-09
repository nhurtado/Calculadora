require 'test_helper'

class DateValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @date_value = date_values(:one)
  end

  test "should get index" do
    get date_values_url
    assert_response :success
  end

  test "should get new" do
    get new_date_value_url
    assert_response :success
  end

  test "should create date_value" do
    assert_difference('DateValue.count') do
      post date_values_url, params: { date_value: { date_v: @date_value.date_v, gold: @date_value.gold, uf: @date_value.uf, usd: @date_value.usd } }
    end

    assert_redirected_to date_value_url(DateValue.last)
  end

  test "should show date_value" do
    get date_value_url(@date_value)
    assert_response :success
  end

  test "should get edit" do
    get edit_date_value_url(@date_value)
    assert_response :success
  end

  test "should update date_value" do
    patch date_value_url(@date_value), params: { date_value: { date_v: @date_value.date_v, gold: @date_value.gold, uf: @date_value.uf, usd: @date_value.usd } }
    assert_redirected_to date_value_url(@date_value)
  end

  test "should destroy date_value" do
    assert_difference('DateValue.count', -1) do
      delete date_value_url(@date_value)
    end

    assert_redirected_to date_values_url
  end
end
