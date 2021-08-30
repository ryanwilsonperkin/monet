class Vendor < ApplicationRecord
  has_many :transactions, dependent: :nullify
  belongs_to :category, optional: true

  delegate :name, to: :category, prefix: true, allow_nil: true
end
