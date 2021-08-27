class ChangePriceColumnsToDecimal < ActiveRecord::Migration[6.1]
  def change
    change_column :transactions, :debit, :decimal
    change_column :transactions, :credit, :decimal
    change_column :transactions, :balance, :decimal
  end
end
