class Discount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :percent_off, :requirement
  validates_numericality_of :percent_off, greater_than: 0, less_than_or_equal_to: 100
  validates_numericality_of :requirement, greater_than: 0
  enum status: %w(inactive active)

  def self.active
    where(status: 1)
  end
end
