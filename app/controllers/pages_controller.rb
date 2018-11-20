

class PagesController < ApplicationController
  def home


    Quote.get_quotes

    @quotes = Quote.all
  end

end
