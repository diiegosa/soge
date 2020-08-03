class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  load_and_authorize_resource

  # Captura exceção de registros que não podem ser deletados por possuir associações
  rescue_from ActiveRecord::InvalidForeignKey do |exception|
    #prev = Rails.application.routes.recognize_path(request.referrer)
    respond_to do |format|
      flash[:error] = translate_message(:invalid_foreign_key)
      format.html { redirect_to request.referrer }
      format.json { render json: { error: flash[:error] } }
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    @error_message = exception.message
    respond_to do |format|
      format.html { render 'errors/401', status: 401 }
    end
  end

  # Define Ability (gem cancancan)
  def current_ability
    @current_ability ||= Acl::Ability.new(current_user)
  end

end