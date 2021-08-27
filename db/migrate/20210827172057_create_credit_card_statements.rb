class CreateCreditCardStatements < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_card_statements do |t|
      t.text :content, null: false
      t.integer :year, null: false
      t.integer :month, null: false

      t.timestamps
    end
  end
end
