

class PagesController < ApplicationController
  def home

    Quote.get_quotes("TYOA-sky", "HKG-sky", "2018-12")


    @quotes = Quote.all
  end

end
