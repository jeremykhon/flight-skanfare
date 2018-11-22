class DealsController < ApplicationController

  def index

    @best_city_deals_list = Deal.top_deals_by_cities
    destination = @best_city_deals_list[0][0]
    destination = params[:name].nil? ? destination : params[:name]
    @topdeals = Deal.top_deals_by_perc_by_cities(destination)
    @chart_id = params[:chart_id]

  end


end
