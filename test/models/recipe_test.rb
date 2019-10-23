# == Schema Information
#
# Table name: recipes
#
#  id              :bigint           not null, primary key
#  description     :text             not null
#  minutes_to_make :integer
#  name            :string(50)       not null
#  visible         :boolean          default(TRUE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require "test_helper"

class RecipeTest < Minitest::Test
  def setup
    super
    @recipe = build(:recipe)
  end

  def test_should_be_valid
    assert @recipe.valid?
  end

  def test_name_should_be_present
    @recipe.name = "     "
    assert !@recipe.valid?
  end

  def test_name_should_be_shorter_than_50_characters
    @recipe.name = random_characters(51)
    assert !@recipe.valid?
  end

  def test_name_can_be_50_characters
    @recipe.name = random_characters(50)
    assert @recipe.valid?
  end

  def test_name_should_be_unique
    create(:recipe, name: @recipe.name)
    assert !@recipe.valid?
  end

  def test_description_should_be_present
    @recipe.description = "     "
    assert !@recipe.valid?
  end

  def test_description_should_be_shorter_than_500_characters
    @recipe.description = random_characters(201)
    assert !@recipe.valid?
  end

  def test_description_can_be_500_characters
    @recipe.description = random_characters(200)
    assert @recipe.valid?
  end

  def test_minutes_to_make_cannot_be_nil
    @recipe.minutes_to_make = nil
    assert !@recipe.valid?
  end

  def test_minutes_to_make_greater_than_zero
    @recipe.minutes_to_make = 0
    assert !@recipe.valid?
  end

  def test_minutes_to_make_less_than1_440
    @recipe.minutes_to_make = 1440
    assert !@recipe.valid?
  end
end
