class Deal < ApplicationRecord
  has_many :historical_deals


  def self.build_deal(origin, destination)
    today = Date.today
    1.upto(60) do |x|
      depart_leg = Quote.find_by(unique_flight: "#{today + x.days}-#{origin}-#{destination}")
      # find depart_leg
      if depart_leg
        1.upto(15).each do |n|
          return_leg = Quote.find_by(unique_flight: "#{today + x.days + n.days}-#{destination}-#{origin}")
          # find return_leg and check if exists
          if return_leg
            d = Deal.new(depart_date: depart_leg.depart_date, return_date: return_leg.depart_date, origin: depart_leg.origin, destination: depart_leg.destination, price: (depart_leg.min_price + return_leg.min_price))
            d.unique_deal = "#{d.depart_date}-#{d.return_date}-#{d.origin}-#{d.destination}"
            found_deal = Deal.find_by(unique_deal: d.unique_deal)
            if found_deal.nil?
              d.save
              HistoricalDeal.create!(deal: d, price: d.price)
            else
              found_deal.price = d.price
              # checking and inserting discount
              found_deal.discount = found_deal.calc_discount
              found_deal.save
              # -----
              HistoricalDeal.create!(deal: found_deal, price: found_deal.price)
              puts '------------------------------'
            end
          end
        end
      end
    end
  end

  def calc_discount
    historical_deals = HistoricalDeal.where(deal_id: self.id).order(created_at: :desc).limit(30)
    last_30_prices = historical_deals.map { |deal| deal.price }
    average_price = last_30_prices.inject { |sum, el| sum + el }.to_f / last_30_prices.size
    discount = average_price - self.price
    return discount
  end

  def self.crawl
    origin = "TYOA-sky"
    destinations = ['HKG-sky']
    dates = ['2018-12', '2019-01', '2019-02']
    # building quotes
    destinations.each do |destination|
      dates.each do |date|
      Quote.get_quotes("TYOA-sky", destination, date)
      end
    end
    # building deals
    destinations.each do |destination|
      build_deal(origin, destination)
    end
  end

  # dates = ['2018-12', '2019-01', '2019-02']
  # destinations = ['HKG-sky', 'BKKT-sky', 'HNLA-sky', 'TPET-sky', 'SELA-sky']

end
