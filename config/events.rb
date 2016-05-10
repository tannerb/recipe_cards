

WebsocketRails::EventMap.describe do
  namespace :crawler do
    subscribe :crawl, :to => WebSearchController, :with_method => :crawl
  end
end