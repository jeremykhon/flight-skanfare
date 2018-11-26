require 'test_helper'

class PreferencesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get preferences_index_url
    assert_response :success
  end

  test "should get create" do
    get preferences_create_url
    assert_response :success
  end

end
