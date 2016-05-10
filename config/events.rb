

WebsocketRails::EventMap.describe do
  namespace :recipes do
    subscribe :crawl, :to => WebSearchController, :with_method => :crawl
  end
end