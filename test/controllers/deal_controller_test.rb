require 'test_helper'

class DealControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get deal_index_url
    assert_response :success
  end
end
