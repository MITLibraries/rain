# == Schema Information
#
# Table name: element_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ElementTypeTest < ActiveSupport::TestCase
  def setup
    @element_type = element_types(:form)
  end

  test 'element_type_count' do
    assert_equal(9, ElementType.count)
  end

  test 'is valid' do
    assert @element_type.valid?
  end

  test 'name should be present' do
    @element_type.name = ''
    assert @element_type.invalid?
  end
end
