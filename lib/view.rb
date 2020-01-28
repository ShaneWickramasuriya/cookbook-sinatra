class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1}. [#{recipe.done}] #{recipe.name} (#{recipe.prep_time} mins)"
    end
  end

  def ask_for_recipe_name
    puts "What are you making?"
    return gets.chomp
  end

  def ask_for_description
    puts "What are the instructions?"
    return gets.chomp
  end

  def ask_for_index(word)
    puts "Which recipe do you want to #{word}?"
    return gets.chomp.to_i
  end

  def ask_for_search
    puts "What are you looking for?"
    return gets.chomp
  end

  def ask_for_prep
    puts "How long does it take to make? (in mins)"
    return gets.chomp.to_i
  end

  def ask_for_difficulty
    puts "How difficult it is to make?"
    return gets.chomp
  end
end
