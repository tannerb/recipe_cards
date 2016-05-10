

class WebSearchController < WebsocketRails::BaseController
  def initialize_session
    controller_store[:results] = 0
  end

  def crawl
    puts "Crawl"
  end
end