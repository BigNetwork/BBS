class StatisticsController < ApplicationController
  def index
    
    all_products = Product.all
    sold_products = Product.all(:conditions => "purchase_id IS NOT NULL")
    
    @sum_of_all_in_registered = 0.0
    for product in all_products
      @sum_of_all_in_registered += product.product_type.purchase_price
    end
    
    @sum_of_all_sold = 0.0
    for product in sold_products
      @sum_of_all_sold += product.product_type.standard_price # TODO: Support stats calculation based on crew price.
    end
    
    @money_to_break_even = @sum_of_all_in_registered - @sum_of_all_sold
    
    @sum_of_sold_profits = 0.0
    for product in sold_products
      @sum_of_sold_profits += product.product_type.profit
    end
    
    @sum_of_total_profits = 0.0
    for product in all_products
      @sum_of_total_profits += product.product_type.profit
    end
    
  end

end
