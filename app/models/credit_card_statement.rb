class CreditCardStatement < ApplicationRecord
  validates :content, :year, :month, presence: true
  validates :year, numericality: { greater_than: 1900, less_than: 3000 }
  validates :month, numericality: { greater_than: 0, less_than: 13 }
end
