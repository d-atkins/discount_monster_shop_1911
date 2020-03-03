require 'rails_helper'

describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :percent_off }
    it { should validate_presence_of :requirement }
    it { should validate_presence_of :active? }
  end

  describe "relationships" do
    it {should belong_to :merchant}
  end
end
