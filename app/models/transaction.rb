class Transaction < ApplicationRecord
  belongs_to :credit_card_statement
end
