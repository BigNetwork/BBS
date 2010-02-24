# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def menu_item(text, url)
    link_to_unless_current(text, url) do
      link_to(text, url, { :class => 'current' })
    end
  end
  
  def sorting_link(name, attribute)
    if params[:sort_how].nil?
      sort_how = 'ASC'
    else  # Flip the coin if we already are sorting in a way:
      if params[:sort_by] == attribute && params[:sort_how] == 'asc'
        sort_how = 'DESC'
      elsif params[:sort_by] == attribute && params[:sort_how] == 'desc' 
        sort_how = 'ASC'
      else
        sort_how = 'ASC'
      end
    end
    if !params[:sort_by].nil? && params[:sort_by] == attribute
      if sort_how == 'ASC'
        arrow_content = '&darr;'
        arrow_direction = 'down'
      else 
        arrow_content = '&uarr;'
        arrow_direction = 'up'
      end
    end
    c = request.path_parameters['controller']
    a = request.path_parameters['action']
    i = request.path_parameters['id']
    if arrow_content.nil?
      arrow = ''
    else
      arrow = " <span class=\"arrow #{arrow_direction}\">" + arrow_content + "</span>"
    end
    link_to name + arrow, { :controller => c, :action => a, :id => i, :sort_by => attribute, :sort_how => sort_how.downcase }, { :class => 'sorting' }
  end
  
end