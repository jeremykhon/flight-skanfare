class Deal < ApplicationRecord
  has_many :historical_deals

  def self.build_deal(origin)
    quotes = Quote.where(origin: origin)
    quotes.each do |depart_leg|
      (2..14).each do |n|
        return_leg = Quote.find_by(unique_flight: "#{depart_leg.depart_date + n.days}-#{depart_leg.destination}-#{depart_leg.origin}")
        if return_leg
          d = Deal.new(depart_date: depart_leg.depart_date, return_date: return_leg.depart_date, origin: depart_leg.origin, destination: depart_leg.destination, price: (depart_leg.min_price + return_leg.min_price))
          d.unique_deal = "#{d.depart_date}-#{d.return_date}-#{d.origin}-#{d.destination}"
          found_deal = Deal.find_by(unique_deal: d.unique_deal)
          if found_deal.nil?
            d.save
            HistoricalDeal.create!(deal: d, price: d.price)
          else
            found_deal.price = d.price
            found_deal.save
            HistoricalDeal.create!(deal: found_deal, price: found_deal.price)
          end
        end
      end
    end
  end

end
