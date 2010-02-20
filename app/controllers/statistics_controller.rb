class StatisticsController < ApplicationController

  before_filter :login_required

  def index
    
    all_products = Product.all
    sold_products = Product.all(:conditions => "purchase_id IS NOT NULL")
    
    @sum_of_all_in_registered = all_products.sum{ |p| p.product_type.purchase_price }
    
    @sum_of_all_sold = 0.0
    for product in sold_products
      @sum_of_all_sold += product.sold_for_price # TODO: Support stats calculation based on crew price.
    end
    
    @money_to_break_even = @sum_of_all_in_registered - @sum_of_all_sold
    @result = @sum_of_all_sold - @sum_of_all_in_registered
    
    @sum_of_sold_profits = 0.0
    for product in sold_products
      @sum_of_sold_profits += product.product_type.profit
    end
    
    @sum_of_total_profits = 0.0
    for product in all_products
      @sum_of_total_profits += product.product_type.profit
    end
    
    times = Array.new
    
    for product in sold_products
      hour = product.purchase.created_at.to_s[11,2].to_i
      if times[hour].nil?
        times[hour] = 1
      else
        times[hour] += 1
      end
    end
    
    times = times.map do |time|
      if time.nil?
        time = 0 if time.nil?
      else
        time = time
      end
    end
    
    #logger.info "#{ProductTypes.first.sold_per_hour}"
    
    GoogleChart::BarChart.new("780x300", t('statistics.index.chart_image_header'), :vertical, false) do |bc|
      bc.data t('statistics.index.chart_sold_products'), times, '009900'
      #bc.data "SecondResultBar", bar_2_data, color_2
      bc.axis :y, :range => [0,times.max]
      bc.axis :x, :labels => (0..23).to_a, :font_size => 10
      bc.show_legend = false
      bc.data_encoding = :extended
      #bc.shape_marker :circle, :color => '00ff00', :data_set_index => 0, :data_point_index => -1, :pixel_size => 10
      @hours_chart_img_url = bc.to_url
    end
    
    GoogleChart::BarChart.new("850x300", t('statistics.index.chart_image_header'), :vertical, false) do |bc|
      for product_type in ProductType.all(:order => :name)
        color = "#{rand(16).to_s(16)}#{rand(16).to_s(16)}#{rand(16).to_s(16)}#{rand(16).to_s(16)}#{rand(16).to_s(16)}#{rand(16).to_s(16)}"
        bc.data product_type.name, product_type.sold_per_hour, color
      end
      bc.axis :y, :range => [0,times.max]
      bc.axis :x, :labels => (0..23).to_a, :font_size => 10
      bc.show_legend = true
      bc.stacked = true
      bc.data_encoding = :extended
      @products_hours_chart_img_url = bc.to_url
    end
    
  end

end
