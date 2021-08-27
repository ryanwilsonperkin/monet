require 'csv'

class CreditCardStatement < ApplicationRecord
  has_many :transactions
  validates :content, :year, :month, presence: true
  validates :year, numericality: { greater_than: 1900, less_than: 3000 }
  validates :month, numericality: { greater_than: 0, less_than: 13 }

  def csv_content
    @csv_content ||= CSVContent.new(content)
  end

  class CSVContent
    include Enumerable

    delegate :each, to: :parsed_content

    def initialize(raw_content)
      @raw_content = raw_content
    end

    def headers
      %w[date transaction debit credit balance]
    end

    def parsed_content
      CSV.parse(@raw_content, headers: headers)
    end
  end
end
