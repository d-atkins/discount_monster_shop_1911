class Discount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :percent_off, :requirement
end
