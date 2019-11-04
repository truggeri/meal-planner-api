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

require "test_helper"

class RecipeIngredientTest < Minitest::Test
  def setup
    super
    @ri = build(:recipe_ingredient)
  end

  def test_should_be_valid
    assert @ri.valid?
  end

  def test_amount_greater_than_zero
    @ri.amount = 0
    assert !@ri.valid?
  end
end
