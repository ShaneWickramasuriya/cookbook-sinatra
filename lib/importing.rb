require 'open-uri'
require 'nokogiri'
require_relative 'recipe'


class Importing
  def initialize(search_term)
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{search_term}"
    html_file = open(url).read
    @doc = Nokogiri::HTML(html_file)
    @names = []
    @descriptions = []
    @prep_time = []
    @difficulties = []
  end

  def names
    @doc.search('.node-recipe')[1..5].each do |headers|
      @names << headers.search('.teaser-item__title a').text.strip
    end
    @names
  end

  def descriptions
    @doc.search('.node-recipe')[1..5].each do |descs|
      @descriptions << descs.search('.field-item').text.strip
    end
    @descriptions
  end

  def prep_time
    @doc.search('.node-recipe')[1..5].each do |times|
      hours = times.search('.teaser-item__info-item--total-time .hours').text.strip.to_i
      mins = times.search('.teaser-item__info-item--total-time .mins').text.strip.to_i
      @prep_time << (hours * 60) + mins
    end
    @prep_time
  end

  def difficulty
    @doc.search('.node-recipe')[1..5].each do |element|
      @difficulties << element.search('.teaser-item__info-item--skill-level').text.strip
    end
    @difficulties
  end

  def results
    instances = []
    names
    descriptions
    prep_time
    difficulty
    @names.each_index do |index|
      instances << Recipe.new(@names[index], @descriptions[index], @prep_time[index], @difficulties[index])
    end
    instances
  end
end
