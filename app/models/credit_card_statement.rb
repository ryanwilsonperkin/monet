class CreditCardStatement < ApplicationRecord
  validates :content, :year, :month, presence: true
end
