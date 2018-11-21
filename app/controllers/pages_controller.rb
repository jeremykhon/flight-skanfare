

class PagesController < ApplicationController
  def home
    @best_deals = Deal.top_deals_by_abs
    @hist_deals_count = HistoricalDeal.count
    @deals_count = Deal.count
  end

end
