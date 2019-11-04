class IngredientInRecipe
  INGREDIENT_FIELDS = %i[name description fresh].freeze
  RI_FIELDS         = %i[id amount measure precise_amount].freeze

  def initialize(recipe_ingredient:)
    @recipe_ingredient = recipe_ingredient
    @ingredient        = recipe_ingredient.ingredient
  end

  def to_h
    ingredient.slice(INGREDIENT_FIELDS).merge(recipe_ingredient.slice(RI_FIELDS))
  end

  private

  attr_reader :ingredient, :recipe_ingredient
end
