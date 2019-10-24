# == Schema Information
#
# Table name: recipe_ingredients
#
#  id             :bigint           not null, primary key
#  recipe_id      :bigint
#  ingredient_id  :bigint
#  amount         :integer          not null
#  measure        :integer          not null
#  precise_amount :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :recipe_ingredient do
    account
    amount          { Random.rand(1..500) }
    measure         { RecipeIngredient.measures.keys.sample }
    precise_amount  { [true, false].sample }

    association :recipe,      factory: :recipe
    association :ingredient,  factory: :ingredient
  end
end
