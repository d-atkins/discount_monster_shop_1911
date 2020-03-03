require 'rails_helper'

RSpec.describe "As a merchant employee" do
  it "I can fill in a form to add a new discount" do
    user = create(:merchant_user)
    discount = create(:random_discount, percent_off: 5, requirement: 5)
    user.merchant.discounts << discount

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit merchant_discounts_path
    click_link("Add a New Bulk Discount")

    fill_in :discount_percent_off, with: 15
    fill_in :discount_requirement, with: 30

    click_button("Create Discount")

    expect(current_path).to eq(merchant_discounts_path)

    expect(page).to have_content('15')
    expect(page).to have_content('30')
  end

  it "I get an error if I leave a field blank" do
    user = create(:merchant_user)
    discount = create(:random_discount, percent_off: 5, requirement: 5)
    user.merchant.discounts << discount

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit merchant_discounts_path
    click_link("Add a New Bulk Discount")

    fill_in :discount_percent_off, with: 15

    click_button("Create Discount")

    expect(page).to have_content("Requirement can't be blank")
    
    user.reload
    visit merchant_discounts_path

    expect(page).to_not have_content('15')
  end
end
