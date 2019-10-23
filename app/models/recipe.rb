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

class Recipe < ActiveRecord::Base
  validates :description, presence: true, length: { maximum: 200 }
  validates :minutes_to_make, numericality: { only_integer: true, greater_than: 0, less_than: 1440 }
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
end
