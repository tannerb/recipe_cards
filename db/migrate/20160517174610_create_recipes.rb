class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.text :name, null: false
      t.text :author
      t.text :image
      t.text :ingredients, array: true
      t.text :recipeYield
      t.text :recipeCuisine
      t.text :recipeCategory
      t.text :prepTime
      t.text :cookTime
      t.text :totalTime
      t.text :recipeInstructions, array: true

      t.text :url

      t.timestamps null: false
    end
  end
end
