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

class RecipeIngredient < ActiveRecord::Base
  belongs_to :account
  belongs_to :ingredient
  belongs_to :recipe

  validates :amount, numericality: { only_integer: true, greater_than: 0 }
  enum measure: {
    item:       0,
    oz:         1,
    gram:       2,
    teaspoon:   3,
    tablespoon: 4,
    cup:        5
  }
end
