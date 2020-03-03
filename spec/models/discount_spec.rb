require 'rails_helper'

describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :percent_off }
    it { should validate_presence_of :requirement }
  end

  describe "relationships" do
    it {should belong_to :merchant}
  end

  describe "instance methods" do
    it "active" do
      discount1 = create(:random_discount)
      discount2 = create(:random_discount)
      create(:random_discount, active?: false)

      expect(Discount.active).to eq([discount1, discount2])
    end
  end
end
