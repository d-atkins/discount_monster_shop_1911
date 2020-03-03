class ChangeActiveToStatusInDiscounts < ActiveRecord::Migration[5.1]
  def change
    remove_column :discounts, :active?, :boolean
    add_column :discounts, :status, :integer, default: 1
  end
end
