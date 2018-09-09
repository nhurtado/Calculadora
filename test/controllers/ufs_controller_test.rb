require 'test_helper'

class UfsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @uf = ufs(:one)
  end

  test "should get index" do
    get ufs_url
    assert_response :success
  end

  test "should get new" do
    get new_uf_url
    assert_response :success
  end

  test "should create uf" do
    assert_difference('Uf.count') do
      post ufs_url, params: { uf: { date_v: @uf.date_v, value: @uf.value } }
    end

    assert_redirected_to uf_url(Uf.last)
  end

  test "should show uf" do
    get uf_url(@uf)
    assert_response :success
  end

  test "should get edit" do
    get edit_uf_url(@uf)
    assert_response :success
  end

  test "should update uf" do
    patch uf_url(@uf), params: { uf: { date_v: @uf.date_v, value: @uf.value } }
    assert_redirected_to uf_url(@uf)
  end

  test "should destroy uf" do
    assert_difference('Uf.count', -1) do
      delete uf_url(@uf)
    end

    assert_redirected_to ufs_url
  end
end
