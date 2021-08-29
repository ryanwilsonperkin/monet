class Vendor < ApplicationRecord
  has_many :transactions, dependent: :nullify
end
