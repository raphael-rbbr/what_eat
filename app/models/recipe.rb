require "open-uri"
require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require "pry-byebug"

class Recipe < ApplicationRecord
  belongs_to :user
  has_many :meals
  has_one_attached :recipe_photo
  has_many :ingredients

  def self.check_intolerances(user)

    current_user = User.find(user.id)

    a = []

    current_user.intolerances.each do |i|
      a << i.intolerance_type
    end

    a.join(",")
  end

  def self.create_user_recipes(user)

    current_user = User.find(user.id)

    # binding.pry

    url_list = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?diet=#{current_user.diet.diet_type}&intolerances=#{check_intolerances(current_user)}")

    http = Net::HTTP.new(url_list.host, url_list.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request_list = Net::HTTP::Get.new(url_list)
    request_list["X-RapidAPI-Host"] = ENV['RECIPE_API_HOST']
    request_list["X-RapidAPI-Key"] = ENV['RECIPE_API_KEY']

    response_list = http.request(request_list).read_body
    list = JSON.parse(response_list)

    # Loop for each result of above list
    # Creating a Recipe for each one

    @recipes = list["results"].each do |r|
      id = r["id"]
      url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/#{id}/information")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Host"] = ENV['RECIPE_API_HOST']
      request["X-RapidAPI-Key"] = ENV['RECIPE_API_KEY']

      response = http.request(request).read_body
      recipe = JSON.parse(response)

      file = URI.open(recipe["image"])

      new_recipe = Recipe.create!(title: recipe["title"],
                                  instructions: recipe["instructions"],
                                  prep_time: recipe["readyInMinutes"],
                                  servings: recipe["servings"],
                                  user_id: current_user.id
      )

      new_recipe.recipe_photo.attach(io: file, filename: 'meal.png', content_type: 'image/png')

      new_recipe.save
    end
  end

end
