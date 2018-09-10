class HomeController < ApplicationController
  def index
    @y = 2018
    if params[:year_selected].present?
      @y = params[:year_selected][:year]
    end
    @ufs = DateValue.where('extract(year from date_v) = ?', @y).to_json
  end
end
