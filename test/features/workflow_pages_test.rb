require 'test_helper'

class WorkflowPagesTest < Capybara::Rails::TestCase
  def setup
    @workflow = workflows(:workflow_one)
    parent = elements(:one)
    fs = Element.create(workflow: @workflow, label: 'Contact Information',
                        element_type: element_types(:fieldset), parent: parent)
    @input_name = Element.create(workflow: @workflow, label: 'Name',
                                 element_type: element_types(:text),
                                 parent: fs, required: true,
                                 error: 'Your name is required.')
    @input_email = Element.create(workflow: @workflow, label: 'Email',
                                  element_type: element_types(:text),
                                  parent: fs, required: false,
                                  help: 'Add your email if you want.')
    Element.create(workflow: @workflow, label: 'Submit!!!',
                   element_type: element_types(:submit), parent: parent)
  end

  test 'can submit valid form' do
    visit workflow_path(@workflow)
    fill_in(@input_name.display_id, with: 'Example User')
    click_on 'Submit!!!'
    assert page.has_content?('Submission was valid.')
  end

  test 'invalid form submission retains values' do
    visit workflow_path(@workflow)
    fill_in(@input_email.display_id, with: 'bob@example.com')
    click_on 'Submit!!!'
    assert_equal(find_field(@input_email.display_id).value, 'bob@example.com')
    refute page.has_content?('Submission was valid.')
  end

  test 'invalid form submission displays errors' do
    visit workflow_path(@workflow)
    page.assert_selector('div.has-error', count: 0)
    fill_in(@input_email.display_id, with: 'bob@example.com')
    click_on 'Submit!!!'
    refute page.has_content?('Submission was valid.')
    assert page.has_content?('There was a problem with the form submission.')
    assert page.has_content?('Your name is required.')
    page.assert_selector('div.has-error', count: 1)
  end
end
