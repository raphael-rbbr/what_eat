require "faker"
require "open-uri"
require 'uri'
require 'net/http'
require 'openssl'
require 'json'

Ingredient.destroy_all
Meal.destroy_all
Recipe.destroy_all
GroceriesList.destroy_all
Plan.destroy_all
Diet.destroy_all
Intolerance.destroy_all
User.destroy_all


users = []
meals = []
recipes = []
lists = []
ingredients = []
plans = []

url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/592479/information")

# ("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?diet=vegetarian&intolerances=peanut,shellfish")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["X-RapidAPI-Host"] = 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
request["X-RapidAPI-Key"] = '8ef426af45msh41e716462eeeb6dp1173a3jsn61455848d5cf'

response = http.request(request).read_body
recipe = JSON.parse(response)

User.create!(email: "nicholas@gmail.com",
                    name: "Nicholas",
                    password: "123456")
puts "User created: #{User.last.email}, password 123456"

Diet.create!(user_id: User.last.id,
             diet_type: 7
)

Intolerance.create!(user_id: User.last.id,
                    intolerance_type: 2
)

Intolerance.create!(user_id: User.last.id,
                    intolerance_type: 3
)

Plan.create!(user_id: User.last.id,
            start_date: "",
            final_date: ""
)
puts "Plan created: #{Plan.last.id}"

GroceriesList.create!(user_id: User.last.id,
                      plan_id: Plan.last.id
)
puts "GroceriesList created: #{GroceriesList.last.id}"

Recipe.create!(title: recipe["title"],
               instructions: recipe["instructions"],
               prep_time: recipe["readyInMinutes"],
               servings: recipe["servings"],
               user_id: User.last.id
               # image: recipe["image"]
)
puts "Recipe created: #{Recipe.last.id} - #{Recipe.last.title}"

Meal.create!(plan_id: Plan.last.id,
             recipe_id: Recipe.last.id
)
puts "Meal created: #{Meal.last.id}"

recipe["extendedIngredients"].each do |i|
  Ingredient.create!(description: i["original"],
                     name: i["name"],
                     quantity: i["amount"],
                     unit: i["unit"],
                     meal_id: Meal.last.id,
                     groceries_list_id: GroceriesList.last.id
  )
  puts "Ingredient created: #{Ingredient.last.id} - #{Ingredient.last.name}"
end










# file = URI.open('https://images.unsplash.com/flagged/photo-1595514191830-3e96a518989b?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687')
# user.profile_photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
