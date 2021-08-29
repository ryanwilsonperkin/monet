class Transaction < ApplicationRecord
  belongs_to :credit_card_statement
  belongs_to :vendor, optional: true

  delegate :name, to: :vendor, prefix: true, allow_nil: true
end
