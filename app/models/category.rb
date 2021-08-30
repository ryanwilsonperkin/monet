class Category < ApplicationRecord
  has_many :vendors, dependent: :nullify
end
