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

require "test_helper"

class AccountTest < Minitest::Test
  def setup
    super
    @account = build(:account)
  end

  def test_should_be_valid
    assert @account.valid?
  end

  def test_name_should_be_present
    @account.name = "     "
    assert !@account.valid?
  end

  def test_name_should_be_shorter_than_50_characters
    @account.name = random_characters(51)
    assert !@account.valid?
  end

  def test_name_can_be_50_characters
    @account.name = random_characters(50)
    assert @account.valid?
  end

  def test_name_should_be_unique
    create(:account, name: @account.name)
    assert !@account.valid?
  end
end
