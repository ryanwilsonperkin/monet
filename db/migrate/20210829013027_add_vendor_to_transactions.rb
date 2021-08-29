class AddVendorToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_reference :transactions, :vendor, null: true, foreign_key: true
  end
end
