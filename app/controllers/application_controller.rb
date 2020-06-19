# coding: utf-8
include ApplicationHelper
include Pagy::Backend

class ApplicationController < ActionController::Base

  before_action :require_login
  before_action :set_cache_headers

  private
  def not_authenticated
    redirect_to root_path, alert: "Você não pode acessar esta página sem estar autenticado."
  end

  def admin_level_check
    not_authenticated unless current_user.level == "admin"
  end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
  end
end