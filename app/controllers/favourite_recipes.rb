class FavouriteRecipesController < ApplicationController
  before_action :set_recipe

  def create
    if Favourite.create favourited: @recipe, user: current_user
      redirect_to @recipe, notice: 'Recipe added to favourites'
    else
      redirect_to @recipe, alert: 'Something went wrong...'
    end
  end


  def destroy
    Favourite.where(favourited_id: @recipe.id, user_id: current_user.id).first.destroy
    redirect_to @recipe, notice 'Recipe removed from favourites'
  end

  private

  def set_recipe
    @recipe  = Recipe.find params[:recipe_id] || params[:id]
  end

end