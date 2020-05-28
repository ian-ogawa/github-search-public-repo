require 'test_helper'

class GithubPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get github_pages_index_url
    assert_response :success
  end

end
