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

FactoryBot.define do
  factory :ingredient do
    name        { FFaker::Food.ingredient }
    description { FFaker::Lorem.phrase }
    fresh       { [true, false].sample }
  end
end
