class PreferencesController < ApplicationController

  def create
    @preference = Preference.new(preference_params)
    @preference.user = current_user
    if @preference.save
      sleep 2
      redirect_to deals_path
    else
      redirect_to new_user_session_path
    end
  end

  def preference_params
    params.require(:preference).permit(:weekday, :duration, :city_id, :discount)
  end
end
