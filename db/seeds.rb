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

def check_intolerances
  a = []

  User.last.intolerances.each do |i|
    a << i.intolerance_type
  end

  a.join(",")
end

# Creating User/Diet/Intolerances for further research with such parameters

User.create!(email: "nicholas@gmail.com",
             name: "Nicholas",
             password: "123456")
puts "User created: #{User.last.email}, password 123456"

profile_file = URI.open('https://images.unsplash.com/flagged/photo-1595514191830-3e96a518989b?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687')
User.last.profile_photo.attach(io: profile_file, filename: 'user.png', content_type: 'image/png')


Diet.create!(user_id: User.last.id,
             diet_type: 7
)

Intolerance.create!(user_id: User.last.id,
                    intolerance_type: 2
)

Intolerance.create!(user_id: User.last.id,
                    intolerance_type: 3
)

# Creating Plan and GroceriesList

Plan.create!(user_id: User.last.id,
  start_date: "",
  final_date: ""
)
puts "Plan created: #{Plan.last.id}"

GroceriesList.create!(user_id: User.last.id,
            plan_id: Plan.last.id
)
puts "GroceriesList created: #{GroceriesList.last.id}"

# Search of recipes list from API based on the User.Diet/Intolerances

url_list = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?diet=#{User.last.diet.diet_type}&intolerances=#{check_intolerances}")

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

list["results"].each do |r|
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

  Recipe.create!(title: recipe["title"],
                 instructions: recipe["instructions"],
                 prep_time: recipe["readyInMinutes"],
                 servings: recipe["servings"],
                 user_id: User.last.id,
  )

  Recipe.last.meal_photo.attach(io: file, filename: 'meal.png', content_type: 'image/png')

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
end
