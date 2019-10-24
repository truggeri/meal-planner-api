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

FactoryBot.define do
  RECIPE_VISIBLE_PERCENTAGE = 70

  factory :recipe do
    account
    description     { FFaker::Lorem.phrase }
    minutes_to_make { Random.rand(1..100) }
    name            { FFaker::Food.ingredient }
    visible         { Random.rand(1..100) < RECIPE_VISIBLE_PERCENTAGE }
  end
end
