class Deal < ApplicationRecord
  has_many :historical_deals

  def self.build_deal(origin, airport)
    today = Date.today
    1.upto(60) do |x|
      depart_leg = depart_leg = Quote.find_by(unique_flight: "#{today + x.days}-#{origin}-#{airport}")
      # p depart_leg
      if depart_leg
        1.upto(15).each do |n|
          return_leg = Quote.find_by(unique_flight: "#{today + x.days + n.days}-#{airport}-#{origin}")
          # p return_leg
          if return_leg
            d = Deal.new(depart_date: depart_leg.depart_date, return_date: return_leg.depart_date, origin: depart_leg.origin, destination: depart_leg.destination, price: (depart_leg.min_price + return_leg.min_price))
            d.unique_deal = "#{d.depart_date}-#{d.return_date}-#{d.origin}-#{d.destination}"
            found_deal = Deal.find_by(unique_deal: d.unique_deal)

            if found_deal.nil?
              d.save
            else
            found_deal.price = d.price
            found_deal.save
            HistoricalDeal.create!(deal: found_deal, price: found_deal.price)
            puts '------------------------------'
            end
          end
        end
      end
    end
  end


  def self.data_fetch
  origin = "TYOA-sky"
  airports = ['HKG-sky', 'BKKT-sky', 'HNLA-sky', 'TPET-sky', 'SIN-sky']
  dates = ['2018-12', '2019-01', '2019-02']
    airports.each do |airport|
      dates.each do |date|
      Quote.get_quotes("TYOA-sky", airport, date)
      end
    end
    airports.each do |airport|
    build_deal(origin, airport)
    end
  end


end
