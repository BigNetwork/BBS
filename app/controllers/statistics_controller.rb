class StatisticsController < ApplicationController

  #before_filter :login_required

  def index
    
    
    ### Fetching models:
    
    all_products = Product.all(:include => [:product_type, :purchase])
    sold_products = Product.all(:include => [:product_type, :purchase], :conditions => "purchase_id IS NOT NULL")
    non_sold_products = all_products - sold_products
    #all_product_types_in_reverse = ProductType.all(:order => "name DESC")
    non_special_offer_product_types_in_reverse = ProductType.all(:conditions => "product_types.id NOT IN (SELECT product_type_relations.parent_id AS id FROM product_type_relations)", :order => "name DESC")
    #all_product_types = ProductType.all(:order => :name)
    non_special_offer_product_types = ProductType.all_non_special_offers
    
    
    
    ### Calculating values:
    
    @sum_of_all_in_registered = Product.total_value
    
    @sum_of_sold_profits = 0.0
    for product in sold_products
      @sum_of_sold_profits += product.profit
    end
    
    @sum_of_total_profits = 0.0
    for product in all_products
      @sum_of_total_profits += product.profit
    end
    
    @sum_of_all_sold = sold_products.sum{ |p| p.sold_for_price }
    @sum_of_non_sold = non_sold_products.sum{ |p| p.product_type.standard_price }
    
    @all_sold_percent = @sum_of_all_sold.to_f / (@sum_of_all_sold.to_f + @sum_of_non_sold.to_f) * 100
    @non_sold_percent = @sum_of_non_sold.to_f / (@sum_of_all_sold.to_f + @sum_of_non_sold.to_f) * 100
    
    @quantity_of_non_sold_products = non_sold_products.size.to_i
    @quantity_of_sold_products = sold_products.size.to_i
    
    @quantity_all_sold_percent = @quantity_of_sold_products.to_f     / (@quantity_of_sold_products.to_f + @quantity_of_non_sold_products.to_f) * 100
    @quantity_non_sold_percent = @quantity_of_non_sold_products.to_f / (@quantity_of_sold_products.to_f + @quantity_of_non_sold_products.to_f) * 100
    
    @money_to_break_even = @sum_of_all_in_registered - @sum_of_all_sold
    @result = @sum_of_all_sold - @sum_of_all_in_registered
    
    
    
    ### Preparing images:
    
    GoogleChart::PieChart.new("370x150", t('statistics.index.chart_pie_money'), false) do |pc|
      pc.data "Sålt (#{sprintf("%2.f", @all_sold_percent)}%)", @sum_of_all_sold
      pc.data "Ej sålt (#{sprintf("%2.f", @non_sold_percent)}%)", @sum_of_non_sold
      @sold_for_chart_url = pc.to_url(:chf => "bg,s,222222", :chco => "009900,663333", :cht => "p3")
    end
    
    GoogleChart::PieChart.new("370x150", t('statistics.index.chart_pie_quantity'), false) do |pc|
      pc.data "Sålt (#{sprintf("%2.f", @quantity_all_sold_percent)}%)", @quantity_of_sold_products
      pc.data "Ej sålt (#{sprintf("%2.f", @quantity_non_sold_percent)}%)", @quantity_of_non_sold_products
      @pie_quantity_chart_url = pc.to_url(:chf => "bg,s,222222", :chco => "009900,663333", :cht => "p3")
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
    
    GoogleChart::BarChart.new("850x350", t('statistics.index.chart_image_header'), :vertical, false) do |bc|
      for product_type in non_special_offer_product_types_in_reverse
        color = "#{rand(16).to_s(16)}#{rand(16).to_s(16)}#{rand(16).to_s(16)}#{rand(16).to_s(16)}#{rand(16).to_s(16)}#{rand(16).to_s(16)}"
        bc.data product_type.name, product_type.sold_per_hour, color
      end
      bc.axis :y, :range => [0,times.max], :color => "aaaaaa"
      bc.axis :x, :labels => (0..23).to_a, :font_size => 10, :color => "aaaaaa"
      #bc.axis :right, :range => [0,times.max], :color => "aaaaaa"
      bc.axis :x, :labels => ['Tidigt', 'Sent'], :positions => [0,100]
      bc.axis :y, :labels => ['Inga', 'Många'], :positions => [0,100]
      bc.show_legend = true
      bc.stacked = true
      bc.data_encoding = :extended
      @products_hours_chart_img_url = bc.to_url :chf => "bg,s,1b1b1b", :chdlp => "r|r", :chtx => "x,x,r,t", :chx1 => "1:|asdf|asd2|3:|asd3|e4"
    end
    
    bc_products_labels = non_special_offer_product_types.map { |pt| "#{pt.name}" }
    bc_products_values = non_special_offer_product_types.map { |pt| "#{pt.quantity_sold}".to_i }
    
    GoogleChart::BarChart.new("850x350", t('statistics.index.chart_products_image_title'), :vertical, false) do |bc|
      bc.data t("statistics.index.sold_items"), bc_products_values, "66cc66"
      bc.axis :x, :labels => bc_products_labels
      bc.axis :y, :range => [0,bc_products_values.max]
      bc.axis :y, :labels => ['Inga', 'Många'], :positions => [0,100]
      bc.show_legend = false
      bc.data_encoding = :extended
      @products_sold_chart_img_url = bc.to_url(:chf => "bg,s,1b1b1b", :chbh => "r,4,8")
    end
    
    bc_products_sums = non_special_offer_product_types.map { |pt| "#{pt.sold_sum}".to_i }
    bc_products_purchased_for = non_special_offer_product_types.map { |pt| "#{pt.purchase_sum}".to_i }
    bc_products_profits = non_special_offer_product_types.map { |pt| "#{pt.profit_sum}".to_i }
    
    GoogleChart::BarChart.new("850x350", t('statistics.index.chart_products_image_title'), :vertical, true) do |bc|
      #bc.data t("statistics.index.sold_items"), bc_products_sums, "6666cc"
      bc.data t("statistics.index.cost_for_items"), bc_products_purchased_for, "cc6666"
      bc.data t("statistics.index.profit_on_items"), bc_products_profits, "66cc66"
      bc.axis :x, :labels => bc_products_labels
      bc.axis :y, :range => [0,bc_products_sums.max]
      bc.axis :y, :labels => ['kr'], :positions => [100]
      bc.show_legend = true
      bc.data_encoding = :extended
      @products_sold_sums_chart_img_url = bc.to_url(:chf => "bg,s,1b1b1b", :chbh => "r,4,8", :chdlp => "b")
    end

    bc_products_percent_sold      = non_special_offer_product_types.map { |pt| "#{pt.quantity_sold.to_f / pt.quantity_delivered.to_f * 100}".to_i }
    bc_products_percent_not_sold  = non_special_offer_product_types.map { |pt| "#{pt.not_sold_products.size.to_f / pt.quantity_delivered.to_f * 100}".to_i }

    GoogleChart::BarChart.new("850x350", t('statistics.index.chart_products_image_title'), :vertical, true) do |bc|
      #bc.data t("statistics.index.sold_items"), bc_products_sums, "6666cc"
      bc.data t("statistics.index.percent_sold"), bc_products_percent_sold, "003300"
      bc.data t("statistics.index.percent_not_sold"), bc_products_percent_not_sold, "cc6666"
      bc.axis :x, :labels => bc_products_labels
      bc.axis :y, :range => [0,100]
      bc.axis :y, :labels => ['Procent'], :positions => [100]
      bc.show_legend = true
      bc.data_encoding = :extended
      @products_sold_percent_chart_img_url = bc.to_url(:chf => "bg,s,1b1b1b", :chbh => "r,4,8", :chdlp => "b")
    end
    
  end
  
  def bigscreen
    #@product_types = ProductType.all
    @product_categories = ProductCategory.all
    @special_product = ProductType.first
  end

end
