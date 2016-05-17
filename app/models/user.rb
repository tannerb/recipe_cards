class User < ActiveRecord::Base
  has_many :favourites
  has_many :favourite_recipes, through: :favourites, source: :favourited, source_type: 'Recipe'
end
