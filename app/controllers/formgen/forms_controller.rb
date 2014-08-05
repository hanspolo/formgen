require_dependency 'formgen/application_controller'

module Formgen
  #
  class FormsController < ApplicationController
    include QuestionsHelper

    before_action :auth_user! unless Formgen.skip_authentication
    before_action :find_form, only: [:edit, :update, :destroy]
    before_action :find_form_with_answers, only: [:show, :send_mail, :export]

    def index
      tabulatr_for current_user.filter_by_context(Formgen::Form.eager_load(:context_tags))
    end

    def show
    end

    def new
      @form = Formgen::Form.new
    end

    def edit
    end

    def create
      @form = Form.new(form_params)
      if @form.save
        flash['notice'] = t('.create_success')
        redirect_to formgen.forms_path
      else
        render :new
      end
    end

    def update
      if @form.update(form_params)
        flash['notice'] = t('.update_success')
        redirect_to formgen.forms_path
      else
        render :edit
      end
    end

    def destroy
      if @form.destroy
        flash['notice'] = t('.remove_success')
      else
        flash['notice'] = t('.remove_problem')
      end
      redirect_to formgen.forms_path
    end

    def send_mail
      FormMailer.send_mail(:inform_all, @form, params[:subject], params[:message])
      redirect_to formgen.form_path(@form)
    end

    def export
      render text: @form.to_csv, content_type: 'text/csv'
    end

    private

    def find_form
      @form = Form.includes(:questions).find params[:id]
    end

    def find_form_with_answers
      @form = Form.includes(:questions, replies: :answers, replies: :user).find params[:id]
    end

    def form_params
      params.require(:form).permit :title, :path, :email, context_tag_ids: [],
                                    questions_attributes:
                                      [:id, :value, :language, :mandatory,
                                       :question_type, :_destroy]
    end
  end
end
