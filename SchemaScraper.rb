require 'net/http'
require 'nokogiri'
require 'set'
require 'uri'

##
# This class is used for crawling a website and parsing schema.org objects
# from its pages
class SchemaScraper

  def initialize(domain, schema_type, properties)
    @start = URI.parse(domain) 
    @host = @start.host

    @schema = schema_type
    @props = properties

    @visited_paths = Set.new []
    @to_visit = []
    @recipes = {}
  end


  def crawl
    # Crawl the domain starting at the base url
    @to_visit << @start

    
    recipes_found = 0
    while recipes_found < 5 do 
      next_url = @to_visit.pop
      puts "Next url: #{next_url}"
      recipe = process_url next_url
    end
  end


  def get_page(url)
    return Nokogiri::HTML Net::HTTP.get url
  end


  def get_links_on_page(uri, page_source)
    # Find all a tags in the source that link to the current domain and 
    # haven't been visited before
    links_on_page = page_source.css 'a'

    # filter down to only unique links on our current domain
    uri_strings = Set.new links_on_page.map { |p| URI.parse(p.attribute('href').to_s) }
    return if uri_strings.nil? or uri_strings.empty?

    uri_strings.delete_if { |ref| ref.path.empty? || ref.host != @host }
    # remove the query string and any anchor
    uri_strings.map! do |url|
      url.fragment = url.query = nil
      url
    end

    uri.query = uri.fragment = nil
    @visited_paths << uri
    # add all paths we haven't previously visited to the list 
    diff = uri_strings - @visited_paths

    @to_visit += diff.to_a
  end


  def parse_schema_object_from_page(page)
    # Build a schema object from a webpage DOM
    page.css("*[itemtype='#{@schema}']").each do |recipe|
      # each value defaults to a list to allow for multiples. i.e ingredients
      recipe_obj = Hash.new { |hash, key| hash[key] = [] }
      # build up an object based on properties pulled from schema.org
      @props.each do |property|
        recipe.css("*[itemprop='#{property}']").each do |val|
          recipe_obj[property] << val.content
          # puts "#{property} : #{val.content}"
        end
      end
      return recipe_obj
    end

    return nil
  end

  def process_url(url)
    # Get the pages source code, append all links to @to_visit and then
    # parse any recipes from the source
    page_source = get_page url
    get_links_on_page url, page_source 
    recipe = parse_schema_object_from_page page_source
    puts recipe unless recipe.nil?
  end
end


props = ['ingredients',
         'recipeYield',
         'prepTime',
         'recipeCuisine',
         'recipeCategory',
         'author',
         'name',
         'image',
         'cookTime',
         'totalTime',
         'instruction',
         'recipeInstruction']


schema_type = "http://schema.org/Recipe"
site = "http://www.vegrecipesofindia.com/"


c = SchemaScraper.new(site, schema_type, props)
c.crawl
