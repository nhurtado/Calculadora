require 'test_helper'

class UsdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usd = usds(:one)
  end

  test "should get index" do
    get usds_url
    assert_response :success
  end

  test "should get new" do
    get new_usd_url
    assert_response :success
  end

  test "should create usd" do
    assert_difference('Usd.count') do
      post usds_url, params: { usd: { date_v: @usd.date_v, value: @usd.value } }
    end

    assert_redirected_to usd_url(Usd.last)
  end

  test "should show usd" do
    get usd_url(@usd)
    assert_response :success
  end

  test "should get edit" do
    get edit_usd_url(@usd)
    assert_response :success
  end

  test "should update usd" do
    patch usd_url(@usd), params: { usd: { date_v: @usd.date_v, value: @usd.value } }
    assert_redirected_to usd_url(@usd)
  end

  test "should destroy usd" do
    assert_difference('Usd.count', -1) do
      delete usd_url(@usd)
    end

    assert_redirected_to usds_url
  end
end
