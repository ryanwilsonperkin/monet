json.extract! credit_card_statement, :id, :content, :year, :month, :created_at, :updated_at
json.url credit_card_statement_url(credit_card_statement, format: :json)
