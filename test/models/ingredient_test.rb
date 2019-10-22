# == Schema Information
#
# Table name: ingredients
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :string           not null
#  fresh       :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require "test_helper"

class IngredientTest < Minitest::Test
  def setup
    super
    @ingredient = build(:ingredient)
  end

  def test_should_be_valid
    assert @ingredient.valid?
  end

  def test_name_should_be_present
    @ingredient.name = "     "
    assert !@ingredient.valid?
  end

  def test_name_should_be_shorter_than_50_characters
    @ingredient.name = random_characters(51)
    assert !@ingredient.valid?
  end

  def test_name_can_be_50_characters
    @ingredient.name = random_characters(50)
    assert @ingredient.valid?
  end

  def test_name_should_be_unique
    create(:ingredient, name: @ingredient.name)
    assert !@ingredient.valid?
  end

  def test_description_should_be_present
    @ingredient.description = "     "
    assert !@ingredient.valid?
  end

  def test_description_should_be_shorter_than_200_characters
    @ingredient.description = random_characters(201)
    assert !@ingredient.valid?
  end

  def test_description_can_be_200_characters
    @ingredient.description = random_characters(200)
    assert @ingredient.valid?
  end

  def test_fresh_defaults_to_false
    @ingredient.fresh = nil
    assert !@ingredient.fresh
  end
end
