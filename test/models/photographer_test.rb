require 'test_helper'

class PhotographerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "photographer attributes must not be empty" do
    photographer = Photographer.new
    assert photographer.invalid?
    assert photographer.errors[:name].any?
    assert photographer.errors[:description].any?
    assert photographer.errors[:email].any?
    assert photographer.errors[:istock_name].any?
    assert photographer.errors[:istock_userid].any?
    assert photographer.errors[:city].any?
    assert photographer.errors[:country].any?
  end
end
