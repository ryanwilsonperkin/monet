class RemoveDateColumnsCreditCardStatement < ActiveRecord::Migration[6.1]
  def change
    remove_column :credit_card_statements, :year
    remove_column :credit_card_statements, :month
  end
end
