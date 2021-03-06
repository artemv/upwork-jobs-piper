# frozen_string_literal: true
class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_action :init_time_zone

  def init_time_zone(&block)
    Time.use_zone('Moscow', &block)
  end

end
