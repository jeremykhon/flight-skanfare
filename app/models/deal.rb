class Deal < ApplicationRecord
  has_many :historical_deals


  def self.build_deal(origin, destination)
    today = Date.today
    1.upto(90) do |x|
      depart_leg = Quote.find_by(unique_flight: "#{today + x.days}-#{origin}-#{destination}")
      # find depart_leg

      if depart_leg
        1.upto(20).each do |n|
          return_leg = Quote.find_by(unique_flight: "#{today + x.days + n.days}-#{destination}-#{origin}")
          # find return_leg for each trip and check if exists

          if return_leg
            d = Deal.new(depart_date: depart_leg.depart_date, return_date: return_leg.depart_date, origin: depart_leg.origin, destination: depart_leg.destination, price: (depart_leg.min_price + return_leg.min_price))
            d.unique_deal = "#{d.depart_date}-#{d.return_date}-#{d.origin}-#{d.destination}"
            # inserting unique id to identify deal later
            d.wday_duration = "#{d.depart_date.wday}-#{n}"
            # inserting weekday duration for user preferences
            found_deal = Deal.find_by(unique_deal: d.unique_deal)
            # inserting weekday duration for user preferences
            if found_deal.nil?
              d.save
              HistoricalDeal.create!(deal: d, price: d.price)
            else
              found_deal.price = d.price
              # checking and inserting discount
              found_deal.discount_abs = found_deal.calc_discount_abs
              found_deal.discount_perc = found_deal.calc_discount_perc
              found_deal.save
              # -----
              HistoricalDeal.create!(deal: found_deal, price: found_deal.price)
            end
          end
        end
      end
    end
  end

  def get_historical
    historical_deals = HistoricalDeal.where(deal_id: self.id)
    graph_data_points = historical_deals.map { |deal| [deal.price, created_at] }
    print graph_data_points
  end

  def self.top_deals_by_abs
    return Deal.order(discount_abs: :asc).limit(30)
  end

  def self.top_deals_by_perc
    return Deal.order(discount_perc: :asc).limit(30)
  end


  def self.top_deals_by_perc_by_cities(destination)
    return Deal.where(destination: destination).order(discount_perc: :asc).limit(30)
  end



  def calc_discount_abs
    historical_deals = HistoricalDeal.where(deal_id: self.id).order(created_at: :desc).limit(30)
    last_30_prices = historical_deals.map { |deal| deal.price }
    average_price = last_30_prices.inject { |sum, el| sum + el }.to_f / last_30_prices.size
    discount = self.price - average_price
    return discount
  end

  def calc_discount_perc
    historical_deals = HistoricalDeal.where(deal_id: self.id).order(created_at: :desc).limit(30)
    last_30_prices = historical_deals.map { |deal| deal.price }
    average_price = last_30_prices.inject { |sum, el| sum + el }.to_f / last_30_prices.size
    discount = (self.price.fdiv(average_price) - 1) * 100
    return discount.round
  end


  def self.crawl
    origin = "TYOA-sky"
    destinations = ['HKG-sky', 'BKKT-sky', 'HNLA-sky', 'TPET-sky', 'SELA-sky']
    dates = ['2018-12', '2019-01', '2019-02', '2019-03']
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

  def self.top_deals_by_cities
    destinations = ['HKG-sky', 'BKKT-sky', 'HNLA-sky', 'TPET-sky', 'SELA-sky']
    h= {'HKG-sky'=> 'HONG KONG', 'BKKT-sky'=> 'BANGKOK', 'HNLA-sky'=> 'HONOLULU', 'SELA-sky'=> 'SEOUL' }

    @best_deals_cities=[]

    destinations.each do |destination|
    d = Deal.where(destination: destination).order(discount_perc: :asc).first
    city_deal= [d.destination, d.discount_perc]
    @best_deals_cities << city_deal

    end
     @best_deals_cities.sort! {|a,b| a[1] <=> b[1]}

    return @best_deals_cities
    end


end
