class RecipesController < ApplicationController

  def index
    # this commented out method will show all recipes for ONLY the specified category
    # @recipes = Recipe.where(category_id:Category.find(params[:category_id]))
    @recipes = Recipe.all

    if @recipes.empty?
      render :json => {
          :error => "No recipes exist yet"
      }
    else
      render :json => {
          :status => "SUCCESS",
          :data => @recipes
      }
    end
  end

  def create
    @new_recipe = Recipe.new(recipe_params)
    if Category.exists?(@new_recipe.category_id)
      if @new_recipe.save
        render :json => {
            :status => "successfully created the recipe",
            :data => @new_recipe
        }
      else
        render :json => {
            :status => "oops something went wrong"
        }
      end
    else
      render :json => {
          :error => "category does not exist"
      }
    end
  end

  def show
    @one_recipe = Recipe.exists?(params[:id])
    if @one_recipe
      render :json => {
          :status => "Recipe found!",
          :data => Recipe.find(params[:id])
      }
    else
      render :json => {
          :error => "No recipe found with id: #{params[:id]}"
      }
    end
  end

  def update
    if (@update_recipe = Recipe.find(params[:id])).present?
      @update_recipe.update(recipe_params)
      render :json => {
          :status => "successfully updated your recipe",
          :data => @update_recipe
      }
    else
      render :json => {
          :error => "Cannot update, no recipe found with id: #{params[:id]}"
      }
    end
  end

  def destroy
    if (@destroy_recipe = Recipe.find(params[:id])).present?
      @destroy_recipe.destroy
      render :json => {
          :status => "Successfully destroyed the recipe",
          :data => @destroy_recipe
      }
    else
      render :json => {
          :error => "record does not exist for recipe with id: #{params[:id]}"
      }
    end
  end

  private

  def recipe_params
    params.permit(:id, :name, :ingredients, :directions, :notes, :tags, :category_id)
  end

end
