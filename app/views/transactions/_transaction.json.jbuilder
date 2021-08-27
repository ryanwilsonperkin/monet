json.extract! transaction, :id, :credit_card_statement_id, :date, :description, :debit, :credit, :balance, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
