class PreferencesController < ApplicationController

  def create
    @preference = Preference.new(preference_params)
    @preference.user = current_user
    if @preference.save
      redirect_to deals_path
    else
      redirect_to profile_path
    end
  end

  def preference_params
    params.require(:preference).permit(:weekday, :duration, :city_id, :discount)
  end
end
