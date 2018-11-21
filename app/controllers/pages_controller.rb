class PagesController < ApplicationController


def test_chart
      @chart_array=[]
      today = Date.today
      x=20
      1.upto(30) do |i|
      inc = rand > 0.3 ? 1 : -1
      x += inc
      jump = i == 30 ? 0.7 :1
      date = today + (i*6).hours
      @chart_array << [date, x * jump]
     end
end

def home
  test_chart
  @best_deals = Deal.top_deals_by_abs
  @hist_deals_count = HistoricalDeal.count
  @deals_count = Deal.count
end

end

