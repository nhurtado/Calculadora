class HomeController < ApplicationController
  def index
    @ufs = DateValue.where('extract(year from date_v) = ?', 1984).where('extract(month from date_v) = ?', 10).to_json
  end
end
