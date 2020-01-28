require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @file = csv_file_path
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_to_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_to_csv
  end

  def mark(index)
    @recipes[index].done = "X"
    save_to_csv
  end

  # private

  def load_csv
    CSV.foreach(@file) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3])
    end
  end

  def save_to_csv
    CSV.open(@file, "wb") do |csv|
      @recipes.each { |recipe| csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty] }
    end
  end
end
