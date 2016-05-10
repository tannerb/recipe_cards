

WebsocketRails::EventMap.describe do
  subscribe :crawl, :to => WebSearchController, :with_method => :crawl
end