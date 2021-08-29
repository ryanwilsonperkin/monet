class Transaction < ApplicationRecord
  belongs_to :credit_card_statement
  belongs_to :vendor, optional: true
end
