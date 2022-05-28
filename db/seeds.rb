require "faker"
require "open-uri"
require 'uri'
require 'net/http'
require 'openssl'
require 'json'

# User.destroy_all
# Meal.destroy_all
# Recipe.destroy_all
# Plan.destroy_all
# GroceriesList.destroy_all
# Ingredient.destroy_all

users = []
meals = []
recipes = []
lists = []
ingredients = []
plans = []

url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/479101/information")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["X-RapidAPI-Host"] = 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
request["X-RapidAPI-Key"] = '8ef426af45msh41e716462eeeb6dp1173a3jsn61455848d5cf'

response = http.request(request).read_body
recipe = JSON.parse(response)

## Puxar ingredientes

recipe["extendedIngredients"].each do |i|
  puts i["original"]
end



# user = User.create!(email: "nicholas@gmail.com",
#                     name: "Nicholas",
#                     password: "123456")
# puts "User test created: #{User.last.email}, password 123456"
# file = URI.open('https://images.unsplash.com/flagged/photo-1595514191830-3e96a518989b?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687')
# user.profile_photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
