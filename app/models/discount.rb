class Discount < ApplicationRecord
  belongs_to :merchant
  validates_presence_of :percent_off, :requirement
  enum status: %w(inactive active)

  def self.active
    where(status: 1)
  end
end
