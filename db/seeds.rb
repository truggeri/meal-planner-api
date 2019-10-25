ingredient_params = [
  { name: "Garlic", description: "A clove of garlic", fresh: true },
  { name: "Pasta", description: "Fresh pasta", fresh: true },
  { name: "Tomato", description: "Fresh tomatoes", fresh: true },
  { name: "Peanut Butter", description: "Peanut butter of any variety", fresh: false },
  { name: "Sliced Bread", description: "Any type", fresh: false }
]

ingredients = {}
ingredient_params.each do |ing|
  ingredients[ing[:name]] = Ingredient.where(
    name:        ing[:name],
    description: ing[:description],
    fresh:       ing[:fresh]
  ).first_or_create!
end
puts "Created #{Ingredient.count} ingredients"

active_act   = Account.where(active: true,  name: "primary account").first_or_create!
disabled_act = Account.where(active: false, name: "inactive account").first_or_create!
puts "Created #{Account.count} accounts"

pasta = Recipe.where(account: active_act,
                               description:     "Fresh pasta with a simple sauce",
                               name:            "Pasta with Marinara",
                               minutes_to_make: 15,
                               visible:         true).first_or_create!
[
  { name: "Garlic", amount: 1, measure: :item },
  { name: "Pasta", amount: 11, measure: :oz },
  { name: "Tomato", amount: 1, measure: :cup }
].each do |ing|
  RecipeIngredient.where(
    account:    pasta.account,
    recipe:     pasta,
    ingredient: ingredients[ing[:name]],
    amount:     ing[:amount],
    measure:    ing[:measure]
  ).first_or_create
end

pb = Recipe.where(account:         disabled_act,
                  description:     "A simple peanut butter sandwich",
                  name:            "PB Sandwich",
                  minutes_to_make: 3,
                  visible:         true).first_or_create!
[
  { name: "Peanut Butter", amount: 2, measure: :oz },
  { name: "Sliced Bread", amount: 2, measure: :item }
].each do |ing|
  RecipeIngredient.where(
    account:    pb.account,
    recipe:     pb,
    ingredient: ingredients[ing[:name]],
    amount:     ing[:amount],
    measure:    ing[:measure]
  ).first_or_create!
end

puts "Created #{Recipe.count} recipes with #{RecipeIngredient.count} ingredients"
