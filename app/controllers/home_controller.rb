class HomeController < ApplicationController
  def index
    dates = [*1984..2018].reverse
    dates_str = dates.map(&:to_s)
    @dates_array = dates_str.zip(dates)
    @today = Date.today
    @y = 2018
    @sd = Date.today
    @td = Date.today
    if params[:quantity].present? && params[:option].present? && params[:start].present? && params[:target].present?
      @q = params[:quantity]
      @sd = Date.parse(params[:start])
      @td = Date.parse(params[:target])
      @o = params[:option].to_i
      if @sd <= @today && @td <=@today
        dv_start = DateValue.where("date_v = ?", @sd).first
	      dv_target = DateValue.where("date_v = ?", @td).first
	      if dv_start.gold.present? && dv_target.gold.present?
      	  @ufs = get_ufs(dv_start,@o,@q)
      	  @target_clp = (@ufs*dv_target.uf).round(2)
      	  @target_usd = (@target_clp/dv_target.usd).round(2)
      	  @target_gold = (@target_clp/dv_target.gold).round(4)
	      elsif dv_start.gold.present?
      	  @ufs = get_ufs(dv_start,@o,@q)
      	  @target_clp = (@ufs*dv_target.uf).round(2)
      	  @target_usd = (@target_clp/dv_target.usd).round(2)
          @w = true
      	  #Warning no starting gold, can't calculate from
	      elsif dv_target.gold.present?
      	  if @o != 4
      	    @ufs = get_ufs(dv_start,@o,@q)
      	    @target_clp = (@ufs*dv_target.uf).round(2)
      	    @target_usd = (@target_clp/dv_target.usd).round(2)
      	    @target_gold = (@target_clp/dv_target.gold).round(4)
      	  end
          @w = true
	        #Warning no target gold, can't calculate to
	      else
      	  if @o != 4
      	    @ufs = get_ufs(dv_start,@o,@q)
      	    @target_clp = (@ufs*dv_target.uf).round(2)
      	    @target_usd = (@target_clp/dv_target.usd).round(2)
      	  end
          @w = true
      	  #Warning no starting or target gold, can't calculate golds
	      end
      end
    end
    if params[:year].present?
      @y = params[:year]
    end
    if @ufs
	    @ufs = @ufs.round(4)
    end
    @uf_values = DateValue.where('extract(year from date_v) = ?', @y).to_json
    puts @w
  end

  protected
  def get_ufs(dv,op,q)
    q = q.to_f
    if op == 1
      return q/dv.uf
    elsif op == 2
      return q
    elsif op == 3
      return q*dv.usd/dv.uf
    elsif op == 4
      return q*dv.gold/dv.uf
    end
  end
end
