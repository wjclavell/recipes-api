class CategoryController < ApplicationController

  def index
    @categories = Category.all
    if @categories.empty?
      render :json => {
          :error => "No categories found"
      }
    else
      render :json => {
          :status => "SUCCESS",
          :data => @categories
      }
    end
  end

  def show
    @one_category = Category.exists?(params[:id])
    if @one_category
      render :json => {
          :status => "You found a category!",
          :data => Category.find(params[:id])
      }
    else
      render :json => {
          :error => "No category found with id: #{params[:id]}"
      }
    end
  end

  def create
    @new_category = Category.new(category_params)
    if @new_category.save
      # show it to the user
      render :json => {
          :status => 'successfully created the Category',
          :data => @new_category
      }
    else
      # if not, then send an error message
      render :json => {
          :error => 'cannot save the data'
      }
    end
  end

  def update
    if (@update_category = Category.find_by_id(params[:id])).present?
      # passing the todo_params which is the "title" and "created_by"
      @update_category.update(category_params)
      render :json => {
          :status => "successfully updated the category",
          :data => @update_category
      }
    else
      render :json => {
          :error => "cannot update the selected category with id: #{params[:id]}"
      }
    end
  end

  def destroy
    if (@destroy_category = Category.find_by_id(params[:id])).present?
      @destroy_category.destroy
      render :json => {
          :response => "successfully deleted the category",
          :data => @destroy_category
      }
    else
      render :json => {
          :error => "record does not exist for category with id: #{params[:id]}"
      }
    end
  end

  private

  def category_params
    params.permit(:id, :title, :description, :created_by)
  end


end
