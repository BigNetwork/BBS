class StatisticsController < ApplicationController

  before_filter :login_required

  use_google_charts

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
    
    dataset = GoogleChartDataset.new :data => [10,50,4,10,16]
    data = GoogleChartData.new :datasets => dataset
    @chart = GoogleLineChart.new :width => 300, :height => 200
    @chart.data = data
    
  end

end
