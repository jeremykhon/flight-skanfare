class Quote < ApplicationRecord

  def self.pull_api(origin_destination, partial_date)
    response = Unirest.get "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browsequotes/v1.0/US/HKD/en-US/#{origin_destination[0]}/#{origin_destination[1]}/#{partial_date}/ ",
      headers:{
        "Accept" => "application/json",
        "X-Mashape-Key" => ENV["RAPID_API_KEY"],
        "X-Mashape-Host" => "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com"
      }
    quotes = response.body["Quotes"]
    return quotes
  end

  def self.get_quotes(origin, destination, partial_date)
    origin_destination = [origin, destination]
    partial_date = partial_date

    (0..1).each do |x|
      # reversing the direction
      origin_destination.reverse! if x == 1

      quotes = nil
      counter = 0

      # pulling data from skyscanner and retrying if it fails
      until (quotes || counter > 3) do
        quotes = pull_api(origin_destination, partial_date)
        counter += 1
      end

      # building a quote instance from each quote result
      if quotes
        quotes.each do |quote|
          if quote["Direct"] == true
            f = Quote.new(min_price: quote["MinPrice"], origin: origin_destination[0], destination: origin_destination[1], direct: quote["Direct"], depart_date: Date.parse(quote["OutboundLeg"]["DepartureDate"]))
            f.unique_flight = "#{f.depart_date}-#{f.origin}-#{f.destination}"
            found_quote = Quote.find_by(unique_flight: f.unique_flight)
            if found_quote.nil?
              f.save
            else
              found_quote.min_price = f.min_price
              found_quote.save
            end
          end
        end
      end
    end
  end



end
