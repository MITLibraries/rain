# == Schema Information
#
# Table name: workflows
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class WorkflowTest < ActiveSupport::TestCase
  def setup
    @workflow = workflows(:workflow_one)
  end

  test 'should be valid' do
    assert @workflow.valid?
  end

  test 'name should be present' do
    @workflow.name = ''
    assert_not @workflow.valid?
  end
end
