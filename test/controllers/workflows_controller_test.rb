require 'test_helper'

class WorkflowsControllerTest < ActionController::TestCase
  test 'show' do
    get :show, id: workflows(:workflow_one)
    assert_response :success
  end
end
