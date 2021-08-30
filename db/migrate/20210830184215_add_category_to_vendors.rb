class AddCategoryToVendors < ActiveRecord::Migration[6.1]
  def change
    add_reference :vendors, :category, null: true, foreign_key: true
  end
end
