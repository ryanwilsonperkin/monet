class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :credit_card_statement, null: false, foreign_key: true
      t.date :date, null: false
      t.string :description, null: false
      t.float :debit
      t.float :credit
      t.float :balance, null: false

      t.timestamps
    end
  end
end
