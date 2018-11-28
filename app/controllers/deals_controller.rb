class DealsController < ApplicationController

  def index
    @best_city_deals_list = Deal.top_deals_by_cities
    @destination = params[:name].nil? ? @best_city_deals_list[0][0] : params[:name]
    duration = params[:duration].nil? ? 0 : params[:duration].to_i
    depart_dow_i = params[:depart_dow].blank? ? 9 :  params[:depart_dow].to_i

    @topdeals = Deal.top_deals_by_price_by_cities(@destination, duration, depart_dow_i)
    @deal_chart = params[:chart_id].nil? ? @topdeals.first : Deal.find(params[:chart_id])
    #params[:chart_id] = @deal_chart
    @city = City.find_by(code: @destination).photo
  end

  def chart
    @deal = Deal.find(params[:id])
    @data = @deal.get_historical.to_json
    puts @data
    respond_to do |format|

        format.html { redirect_to deals_path }
        format.js  # <-- will render `app/views/deals/index.js.erb`
      end

  end


  def show
    @deal = Deal.find(params[:id])
    @itineraries = []
  end

  def show_loaded
    @deal = Deal.find(params[:id])

    if params[:key]
      @key = params[:key]
      results = fetch_results_with_session_id(@key)
      @itineraries = results["Itineraries"]
      @legs = results["Legs"]
      @carriers = results["Carriers"]
      @agents = results["Agents"]
      @places = results["Places"]
      puts 'part 1'
    else
      response = call_api(@deal)
      if response.headers[:location].nil?
        while response.headers[:location].nil? do
          response = call_api(@deal)
          sleep 1
        end
      end
      @itineraries = []
      @key = response.headers[:location].split("/").last
    end

      # respond_to do |format|
      #   format.html { redirect_to deal_path(@deal) }
      #   format.js
      # end
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
