require 'rails_helper'

RSpec.describe "As a merchant employee" do
  it "I can deactivate a discount" do
    user = create(:merchant_user)
    discount = create(:random_discount, percent_off: 5, requirement: 5)
    user.merchant.discounts << discount

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit merchant_discounts_path
    click_link("Deactivate")
    expect(current_path).to eq(merchant_discounts_path)
    user.reload
    visit merchant_discounts_path
    expect(page).to_not have_content(5)
  end
end
