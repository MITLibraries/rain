# == Schema Information
#
# Table name: elements
#
#  id              :integer          not null, primary key
#  workflow_id     :integer
#  element_type_id :integer
#  label           :string
#  help            :string
#  error           :string
#  parent_id       :integer
#  required        :boolean          default(FALSE)
#  position        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class ElementTest < ActiveSupport::TestCase
  def setup
    @workflow = workflows(:workflow_one)
    @element = elements(:one)
  end

  test 'should be valid' do
    assert @element.valid?
  end

  test 'workflow_id should be present' do
    @element.workflow_id = ''
    assert @element.invalid?
  end

  test 'element_type_id should be present' do
    @element.element_type_id = ''
    assert @element.invalid?
  end

  test 'accepted_element_type_ids' do
    input_text_id = element_types(:text).id
    fieldset_id = element_types(:fieldset).id
    form_id = element_types(:form).id
    textarea_id = element_types(:textarea).id
    assert @element.accepted_element_type_ids.include?(input_text_id)
    assert @element.accepted_element_type_ids.include?(fieldset_id)
    assert @element.accepted_element_type_ids.exclude?(form_id)
    assert @element.accepted_element_type_ids.exclude?(textarea_id)
  end

  test 'accepted_element_types' do
    assert @element.accepted_element_types.include?(element_types(:text))
    assert @element.accepted_element_types.include?(element_types(:fieldset))
    assert @element.accepted_element_types.exclude?(element_types(:form))
    assert @element.accepted_element_types.exclude?(element_types(:textarea))
  end

  test 'accepts_type' do
    assert @element.accepts_type?(element_types(:text))
    assert @element.accepts_type?(element_types(:fieldset))
    assert_not @element.accepts_type?(element_types(:form))
    assert_not @element.accepts_type?(element_types(:textarea))
  end

  test 'valid with legal_parent' do
    parent = elements(:one)
    e = Element.new(workflow: workflows(:workflow_one),
                    element_type: element_types(:fieldset), parent: parent)
    assert e.valid?
  end

  test 'invalid with illegal_parent' do
    parent = elements(:one)
    e = Element.new(workflow: workflows(:workflow_one),
                    element_type: element_types(:radio), parent: parent)
    assert e.invalid?
  end

  test 'can move up in order' do
    workflow = workflows(:workflow_one)
    parent = elements(:one)
    e1 = Element.create(workflow: workflow, label: 'e1',
                        element_type: element_types(:text), parent: parent)
    e2 = Element.create(workflow: workflow, label: 'e2',
                        element_type: element_types(:text), parent: parent)
    assert_equal(1, e1.position)
    assert_equal(2, e2.position)
    assert_equal(e1, parent.children.first)
    assert_equal(e2, parent.children.last)
    parent.children.first.move_lower
    assert_equal(2, e1.reload.position)
    assert_equal(1, e2.reload.position)
    assert_equal(e2, parent.children.first)
    assert_equal(e1, parent.children.last)
  end

  test 'traverse from root' do
    workflow = workflows(:workflow_one)
    top_form = elements(:one)
    top_form.label = 'form'
    top_form.save!
    Element.create(workflow: workflow, label: 'input_text',
                   element_type: element_types(:text), parent: top_form)
    fs1 = Element.create(workflow: workflow, label: 'fieldset_one',
                         element_type: element_types(:fieldset),
                         parent: top_form)
    Element.create(workflow: workflow, label: 'fieldset_two',
                   element_type: element_types(:fieldset), parent: top_form)
    Element.create(workflow: workflow, label: 'input_text2',
                   element_type: element_types(:text), parent: fs1)
    a = []
    top_form.traverse { |e, f| a << "#{e.label}#{f}" }
    assert_equal(15, a.size)
    assert_equal('form_open', a[0])
    assert_equal('form', a[1])
    assert_equal('input_text_open', a[2])
    assert_equal('input_text', a[3])
    assert_equal('input_text_close', a[4])
    assert_equal('fieldset_one_open', a[5])
    assert_equal('fieldset_one', a[6])
    assert_equal('input_text2_open', a[7])
    assert_equal('input_text2', a[8])
    assert_equal('input_text2_close', a[9])
    assert_equal('fieldset_one_close', a[10])
    assert_equal('fieldset_two_open', a[11])
    assert_equal('fieldset_two', a[12])
    assert_equal('fieldset_two_close', a[13])
    assert_equal('form_close', a[14])
  end
end
