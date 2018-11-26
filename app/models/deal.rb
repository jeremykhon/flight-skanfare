class Deal < ApplicationRecord
  belongs_to :city

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
            found_deal = Deal.find_by(unique_deal: d.unique_deal)
            # inserting weekday duration for user preferences
            if found_deal.nil?
              d.historical = [{"datetime" => Time.now, "price" => d.price}]
              d.weekday = d.depart_date.wday
              d.duration = n
              d.city = City.find_by(code: destination)
              d.save
            else
              found_deal.price = d.price
              # checking and inserting discount
              found_deal.discount_abs = found_deal.calc_discount_abs
              found_deal.discount_perc = found_deal.calc_discount_perc
              found_deal.weekday = found_deal.depart_date.wday
              found_deal.duration = n
              found_deal.city = City.find_by(code: destination)
              found_deal.historical.push({"datetime" => Time.now, "price" => found_deal.price})
              found_deal.save
              # -----
            end
          end
        end
      end
    end
  end

  def get_historical
    graph_points = self.historical.map { |hash| [DateTime.parse(hash["datetime"]), hash["price"]]}
    return graph_points
  end

  def self.top_deals_by_abs
    return Deal.order(discount_abs: :asc).limit(30)
  end

  def self.top_deals_by_perc
    return Deal.order(discount_perc: :asc).limit(30)
  end

  def self.top_deals_by_price
    return Deal.order(price: :asc).limit(30)
  end

  def self.top_deals_by_perc_by_cities(destination)

  return Deal.where(destination: destination).order(discount_perc: :asc).limit(30)
  end

  def self.top_deals_by_price_by_cities(destination, duration, depart_dow)

    if duration > 0 and depart_dow > 0
     return Deal.where(destination: destination).where(weekday: depart_dow).where(duration: duration).order(price: :asc).limit(30)
    elsif duration >1 and depart_dow == 0
      return Deal.where(destination: destination).where(duration: duration).order(price: :asc).limit(30)
    else
      return Deal.where(destination: destination).where(weekday: depart_dow).order(price: :asc).limit(30)
   end
      return Deal.where(destination: destination).order(price: :asc).limit(30)
  end

  def calc_discount_abs
    last_30_hash = self.historical.last(30)
    last_30_prices = last_30_hash.map { |hash| hash["price"] }
    average_price = last_30_prices.inject { |sum, el| sum + el }.to_f / last_30_prices.size
    discount = self.price - average_price
    return discount
  end

  def calc_discount_perc
    last_30_hash = self.historical.last(30)
    last_30_prices = last_30_hash.map { |hash| hash["price"] }
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


    @best_deals_cities=[]

    destinations.each do |destination|
      d = Deal.where(destination: destination).order(price: :asc).first
      city_deal= [d.destination, d.price]
      @best_deals_cities << city_deal
    end
    @best_deals_cities.sort! {|a,b| a[1] <=> b[1]}
    return @best_deals_cities
  end

  def self.city(airport)
    h= {'HKG-sky'=> 'hongkong_new', 'BKKT-sky'=> 'bangkok_new', 'HNLA-sky'=> 'honolulu_new', 'SELA-sky'=> 'seoul_new', 'TPET-sky' => "taipei_new" }
    return h[airport]
  end

  def self.humanize_city(destination)
    h= {'HKG-sky'=> 'Hong Kong', 'BKKT-sky'=> 'Bangkok', 'HNLA-sky'=> 'Honolulu', 'SELA-sky'=> 'Seoul', 'TPET-sky' => "Taipei", 'TYOA-sky' => "Tokyo" }
    return h[destination]
  end

  def self.int_dow(dow)
    h= {'Mon'=> 1, 'Tue' => 2, 'Wed'=> 3, 'Thu'=> 4, 'Fri'=> 5, 'Sat'=> 6, 'Sun'=> 7}
    return h[dow]
  end

  def self.dow_int(dow)
   h= ['Any', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    return h[dow]
  end

end
