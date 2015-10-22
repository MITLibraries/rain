class WorkflowsController < ApplicationController
  def show
    @workflow = Workflow.find(params[:id])
  end

  def form_submit
    @workflow = Workflow.find(params[:id])
    @form_errors = error_check(@workflow, params)

    if @form_errors.empty?
      flash[:success] = 'Submission was valid.'
      redirect_to root_path
    else
      flash[:danger] = 'There was a problem with the form submission.'
      render 'show'
    end
  end

  private

  def error_check(wf, params)
    required_fields = wf.elements.map { |e| e.display_id if e.required }.compact
    required_fields.map { |field| field unless params[field].present? }.compact
  end
end
