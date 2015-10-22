# == Schema Information
#
# Table name: element_type_accepts
#
#  id                      :integer          not null, primary key
#  element_type_id         :integer
#  accepts_element_type_id :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'test_helper'

class ElementTypeAcceptTest < ActiveSupport::TestCase
  def setup
    @element_type_accepts = element_type_accepts(:form_text)
  end

  test 'is valid' do
    assert @element_type_accepts.valid?
  end

  test 'requires element_type_id' do
    @element_type_accepts.element_type_id = ''
    assert @element_type_accepts.invalid?
  end

  test 'requires accepts_element_type_id' do
    @element_type_accepts.accepts_element_type_id = ''
    assert @element_type_accepts.invalid?
  end

  test 'element type can be nested if allowed' do
    @element_type_one = element_types(:form)
    @element_type_two = element_types(:text)
  end

  test 'element type cannot be nested if not allowed' do
    @element_type_one = element_types(:form)
    @element_type_two = element_types(:text)
  end
end
