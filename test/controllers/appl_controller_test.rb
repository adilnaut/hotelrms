require 'test_helper'

class ApplControllerTest < ActionDispatch::IntegrationTest
  test "should get rnew" do
    get appl_rnew_url
    assert_response :success
  end

  test "should get cnew" do
    get appl_cnew_url
    assert_response :success
  end

  test "should get show" do
    get appl_show_url
    assert_response :success
  end

  test "should get index" do
    get appl_index_url
    assert_response :success
  end

end
