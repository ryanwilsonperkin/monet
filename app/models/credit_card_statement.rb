require 'csv'

class CreditCardStatement < ApplicationRecord
  has_many :transactions, dependent: :destroy
  validates :content, :year, :month, presence: true
  validates :year, numericality: { greater_than: 1900, less_than: 3000 }
  validates :month, numericality: { greater_than: 0, less_than: 13 }

  after_create :create_transactions!

  def csv_content
    @csv_content ||= CSVContent.new(content)
  end

  class CSVContent
    include Enumerable

    HEADERS = %w[date description debit credit balance]

    def initialize(raw_content)
      @raw_content = raw_content
    end

    def headers
      HEADERS
    end

    def each
      parsed_content.each do |row|
        yield CSVContentRow.new(row)
      end
    end

    def parsed_content
      CSV.parse(@raw_content, headers: headers)
    end

    class CSVContentRow
      include Enumerable

      def initialize(csv_row)
        @csv_row = csv_row
      end

      def each
        CSVContent::HEADERS.each do |header|
          yield send(header)
        end
      end

      def to_h
        Hash[CSVContent::HEADERS.map { |header| [header, send(header)] }]
      end

      def date
        # Account statement CSVs stupidly use MM/DD/YYYY format
        Date.strptime(@csv_row["date"], "%m/%d/%Y")
      end

      def method_missing(m)
        key = m.to_s
        if @csv_row.has_key?(key)
          @csv_row[key]
        else
          super
        end
      end
    end
  end

  private

  def create_transactions!
    transaction do
      transactions.create!(csv_content.map { |row| row.to_h })
    end
  end
end
