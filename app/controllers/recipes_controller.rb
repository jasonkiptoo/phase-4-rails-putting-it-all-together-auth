class RecipesController < ApplicationController
  before_action :authorized
  def index
    recipes = Recipe.all
    render json: recipes
  end


  def create
    recipe = Recipe.create(user_id: session[:user_id], title:recipe_params[:title], instructions:recipe_params[:instructions], minutes_to_complete:recipe_params[:minutes_to_complete])
    # recipe = Recipe.create(recipe_params)
        if recipe.valid?
      render json: recipe, status: :created
    else
      render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete, :user_id)
  end
  def authorized
    render json: { errors: ['Not Authorized Please log in'] }, status: :unauthorized unless session.include? :user_id
  end


end
