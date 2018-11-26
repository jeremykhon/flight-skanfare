class DealsController < ApplicationController

  def index
    @best_city_deals_list = Deal.top_deals_by_cities
    destination = @best_city_deals_list[0][0]

    destination = params[:name].nil? ? destination : params[:name]
    duration = params[:duration].nil? ? 0 : params[:duration].to_i
    depart_dow_i = params[:depart_dow].blank? ? 0 :  Deal.int_dow((params[:depart_dow].capitalize.first(3)))


    @topdeals = Deal.top_deals_by_price_by_cities(destination, duration, depart_dow_i)
    @deal_chart = params[:chart_id].nil? ? @topdeals.first : Deal.find(params[:chart_id])
    params[:chart_id] = @deal_chart
    @city = Deal.city(destination)
  end

  def show
    @deal = Deal.find(params[:id])
    if params[:key]
      @key = params[:key]
      results = fetch_results_with_session_id(@key)
    else
      response = call_api(@deal)
      if response.nil?
        while response.nil? do
          response = call_api(@deal)
          sleep 1
        end
      end
      @key = response.headers[:location].split("/").last
      results = fetch_results_with_session_id(@key)
    end
    @itineraries = results["Itineraries"]
    @legs = results["Legs"]
    @carriers = results["Carriers"]
    @agents = results["Agents"]
    @places = results["Places"]

  end

  def call_api(deal)
    response = Unirest.post "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/pricing/v1.0",
        headers:{
          "Content-Type" => "application/x-www-form-urlencoded",
          "X-Mashape-Key" => ENV["RAPID_API_KEY"],
          "X-Mashape-Host" => "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com"
        },
        parameters:{
          "country" => "JP",
          "currency" => "JPY",
          "locale" => "en-US",
          "originPlace" => @deal.origin,
          "destinationPlace" => @deal.destination,
          "outboundDate" => @deal.depart_date.strftime("%Y-%m-%d"),
          "inboundDate" => @deal.return_date.strftime("%Y-%m-%d"),
          "cabinClass" => "economy",
          "adults" => 1,
          "children" => 0,
          "infants" => 0,
          "includeCarriers" => "",
          "excludeCarriers" => "",
          "groupPricing" => "false"
        }
    return response
  end

  def fetch_results_with_session_id(session_id)
    response = Unirest.get("https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/pricing/uk2/v1.0/#{session_id}?sortType=price&sortOrder=asc&stops=0&pageIndex=0&pageSize=10",
    headers: {
      "Accept" => "application/json",
      "X-Mashape-Key" => ENV["RAPID_API_KEY"],
      "X-Mashape-Host" => "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com"
    })
    p headers
    return response.body
  end


end
