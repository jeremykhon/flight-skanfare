class PagesController < ApplicationController
  def home
    # response = Unirest.get "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browsequotes/v1.0/US/HKD/en-US/TYOA-sky/HKG-sky/2018-12/ ",
  #   headers:{
  #   "Accept" => "application/json",
  #   "X-Mashape-Key" => ENV["RAPID_API_KEY"],
  #   "X-Mashape-Host" => "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com"
  # }
    # @quotes = response.body["Quotes"]
  end
end

