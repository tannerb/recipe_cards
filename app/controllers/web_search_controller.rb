

class WebSearchController < WebsocketRails::BaseController
  def initialize_session
  end

  def crawl
    puts 'crawling', message
    send_message :crawling, message, :namespace => :crawler
  end
end