require 'httparty'
require 'rubygems'
require 'json'

namespace :tasks do
  desc "fill db."
  task :run => [:del_all,:pop_all]

  desc "delelete previous data."
  task :del_all => [:delete_uf, :delete_usd, :delete_gold, :delete_dv]

  desc "fill new data."
  task :pop_all => [:pop_uf, :pop_usd, :pop_gold, :fusion]

	desc 'populate db'
	task :pop_uf => :environment do
		url = 'https://mindicador.cl/api/uf/'
		ys = [*1984..2018]
		current_date = Date.parse("1984-01-01")
		ys.each do |y|
		  urly = "#{url}#{y}"
		  response = HTTParty.get(urly)
		  rJ = JSON.parse(response.body)
		  rS = rJ['serie'].reverse
		  rS.each do |array|
		    d = DateTime.parse(array['fecha'])
		    d_n = Date.parse("#{d.year}-#{d.month}-#{d.day}")
		    while d_n > current_date
		      aux_uf = Uf.where(date_v: current_date-1).first
					ua = Uf.create(date_v: current_date,value: aux_uf.value)
		      current_date = current_date + 1
		    end
		    if !Uf.where(date_v: d_n).exists?
		      ub = Uf.create(date_v: d_n,value: array['valor'])
		      current_date = current_date + 1
		    end
		  end
		end
	end

	desc 'populate db'
	task :pop_usd => :environment do
		url = 'https://mindicador.cl/api/dolar/'
		ys = [*1984..2018]
		current_date = Date.parse("1984-01-01")
		Usd.create(date_v: current_date,value: 87.54)
		ys.each do |y|
		  urly = "#{url}#{y}"
		  response = HTTParty.get(urly)
		  rJ = JSON.parse(response.body)
		  rS = rJ['serie'].reverse
		  rS.each do |array|
		    d = DateTime.parse(array['fecha'])
		    d_n = Date.parse("#{d.year}-#{d.month}-#{d.day}")
		    while d_n > current_date
		      aux_date = current_date-1
					if Usd.where(date_v: aux_date).exists?
		        aux_usd = Usd.where(date_v: aux_date).first
						Usd.create(date_v: current_date,value: aux_usd.value)
		      end
		      current_date = current_date + 1
		    end
		    Usd.create(date_v: current_date, value: array['valor'])
		    current_date = current_date + 1
		  end
		end
	end

	desc 'populate db'
	task :pop_gold => :environment do
		url = 'https://www.quandl.com/api/v3/datasets/WGC/GOLD_DAILY_USD.json?start_date=1984-01-01&api_key=x9UyVfiqJDPfGg8RkUj-'
		ys = [*1984..2018]
		current_date = Date.parse("1984-01-01")
		usd_value = Usd.where(date_v: current_date).first
		Gold.create(date_v: current_date,value: (382.4*usd_value.value/31.1035).round(2))
		current_date = Date.parse("1984-01-02")
		response = HTTParty.get(url)
		rJ = JSON.parse(response.body)
		rS = rJ['dataset']['data'].reverse
		rS.each do |array|
		  array_date = Date.parse(array[0])
		  while current_date < array_date
		    prev_gold = Gold.where(date_v: current_date-1).first
		    Gold.create(date_v: current_date,value: prev_gold.value)
		    current_date = current_date +1
		  end
		  usd = Usd.where(date_v: current_date).first
		  Gold.create(date_v: current_date,value: (array[1]*usd.value/31.1035).round(2))
		  current_date = current_date +1
		end
	end

	desc 'fusion'
	task :fusion => :environment do
		current_date = Date.parse("1984-01-01")
		target_date = Date.today
		while current_date <= target_date
		  uf = Uf.where(date_v: current_date).first
		  usd = Usd.where(date_v: current_date).first
		  gold = Gold.where(date_v: current_date).first
		  if !gold.nil?
		    DateValue.create(date_v: current_date, uf: uf.value, usd: usd.value, gold: gold.value)
		  else
		    DateValue.create(date_v: current_date, uf: uf.value, usd: usd.value)
		  end
		  current_date = current_date+1
		end
	end

	desc 'delete ufs'
	task :delete_uf => :environment do
		Uf.delete_all
	end

	desc 'delete usd'
	task :delete_usd => :environment do
		Usd.delete_all
	end

	desc 'delete gold'
	task :delete_gold => :environment do
		Gold.delete_all
	end

	desc 'delete dv'
	task :delete_dv => :environment do
		DateValue.delete_all
	end
end


