class PreferencesController < ApplicationController

  def create
    @preference = Preference.new(preference_params)
    @preference.user = current_user
    if @preference.save
      redirect_to profile_path
    else
      @user = current_user
      @preferences = Preference.where(user: current_user)
      render 'pages/profile'
    end
  end

  def preference_params
    params.require(:preference).permit(:weekday, :duration, :city_id)
  end
end
