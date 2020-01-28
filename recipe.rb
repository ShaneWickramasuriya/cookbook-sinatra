class Recipe
  attr_reader :name, :description, :prep_time, :difficulty
  attr_accessor :done
  def initialize(name, description, prep, difficulty, done = " ")
    @name = name
    @description = description
    @prep_time = prep
    @difficulty = difficulty
    @done = done
  end
end
