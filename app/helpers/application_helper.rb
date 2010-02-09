# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def menu_item(text, url)
    link_to_unless_current(text, url) do
      link_to(text, url, { :class => 'current' })
    end
  end
end
