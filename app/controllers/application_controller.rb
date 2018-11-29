class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource_or_scope)
    deals_path
  end

  def after_sign_up_path_for(resource_or_scope)
    deals_path
  end

  def default_url_options
  { host: ENV["HOST"] || "localhost:3000" }
  end
end
