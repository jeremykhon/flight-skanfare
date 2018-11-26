class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  def profile
    @user = current_user
    @preferences = Preference.where(user: current_user)
    @preference = Preference.new
  end

  def home
  end

end

