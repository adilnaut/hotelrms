require 'test_helper'

class WorkerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get worker_new_url
    assert_response :success
  end

  test "should get show" do
    get worker_show_url
    assert_response :success
  end

  test "should get upgrade" do
    get worker_upgrade_url
    assert_response :success
  end

end
