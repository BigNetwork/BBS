# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def in_SEK(float)
    sprintf("%.2f kr", float)
  end
end
