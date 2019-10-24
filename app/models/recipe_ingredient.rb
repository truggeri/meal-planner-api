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
    oz:         0,
    gram:       1,
    teaspoon:   2,
    tablespoon: 3,
    cup:        4
  }
end
