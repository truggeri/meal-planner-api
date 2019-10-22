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

class Ingredient < ActiveRecord::Base
  validates   :name,        presence: true, length: { maximum: 50 }, uniqueness: true
  validates   :description, presence: true, length: { maximum: 200 }
end
