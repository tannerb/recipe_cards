class Favourite < ActiveRecord::Base
  belongs_to :favourited, polymorphic: true
  belongs_to :user
end