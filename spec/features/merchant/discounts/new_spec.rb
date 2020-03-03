require 'rails_helper'

RSpec.describe "As a merchant employee" do
  it "I can fill in a form to add a new discount" do
    user = create(:merchant_user)
    discount = create(:random_discount, percent_off: 5, requirement: 5)
    user.merchant.discounts << discount

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit merchant_discounts_path
    click_link("Add a New Bulk Discount")

    fill_in :percent_off, with: 15
    fill_in :requirement, with: 30

    click_button("Submit")

    expect(current_path).to eq(merchant_discounts_path)

    expect(page).to have_content('15')
    expect(page).to have_content('30')
  end
end
