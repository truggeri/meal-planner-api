# == Schema Information
#
# Table name: accounts
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(TRUE), not null
#  name        :string           not null
#  users_count :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :account, class: :account do
    active      { true }
    name        { FFaker::Name.html_safe_name }
  end
end
