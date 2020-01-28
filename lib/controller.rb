# initialize(cookbook) takes an instance of the Cookbook as an argument.
# list all the recipes
# create a new recipe
# destroy an existing recipe
require_relative "view"
require_relative "recipe"
require_relative "importing"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    recipes = @cookbook.all
    @view.display(recipes)
  end

  def create
    name = @view.ask_for_recipe_name
    description = @view.ask_for_description
    prep_time = @view.ask_for_prep
    difficulty = @view.ask_for_difficulty

    recipe = Recipe.new(name, description, prep_time, difficulty)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    list
    index = @view.ask_for_index("delete") - 1
    @cookbook.remove_recipe(index)
  end

  def import
    term = @view.ask_for_search
    search = Importing.new(term) # look_up(search)
    results = search.results
    @view.display(results)
    index = @view.ask_for_index("import") - 1
    @cookbook.add_recipe(results[index])
  end

  def mark_as_done!
    list
    index = @view.ask_for_index("mark as done") - 1
    @cookbook.mark(index)
  end
end
