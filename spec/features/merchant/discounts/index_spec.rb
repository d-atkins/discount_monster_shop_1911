require 'rails_helper'

RSpec.describe "As a merchant employee" do
  it "I can see all of the discounts for my store" do
    user = create(:merchant_user)
    discount = create(:random_discount)
    user.merchant.discounts << discount

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/merchant'
    click_link("My Bulk Discounts")

    expect(current_path).to eq('/merchant/discounts')

    within("#discount-#{discount.id}") { expect(page).to have_content(discount.percent_off) }
    within("#discount-#{discount.id}") { expect(page).to have_content(discount.requirement) }
  end
end
