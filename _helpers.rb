require 'cgi'

module Helpers
  def format_date date
    date.strftime('%a, %d %B %Y')
  end

  def urlencode s
    CGI.escape s
  end

  def sort_categories categories
    categories.to_a.sort
  end

  def category_url category
    "/categories.html##{urlencode(category)}"
  end
end
