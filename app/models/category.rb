class Category < ApplicationRecord
  has_many :vendors, dependent: :nullify

  def icon_name
    [icon, name].join " "
  end
end
