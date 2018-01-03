require 'test_helper'

class StaticPageControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get static_page_main_url
    assert_response :success
  end

end
