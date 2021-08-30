class Vendor < ApplicationRecord
  has_many :transactions, dependent: :nullify
  belongs_to :category, optional: true
end
