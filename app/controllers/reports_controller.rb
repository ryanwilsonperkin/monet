class ReportsController < ApplicationController
  class InvalidParam < StandardError; end
  rescue_from InvalidParam, with: :redirect_to_index

  # GET /
  def index
    @report_year_months = Transaction
      .order(date: :desc)
      .distinct
      .pluck(:date)
      .map { |date| [date.year, date.month] }
      .uniq
  end

  # GET /reports/monthly
  def monthly
    @year = year_param
    @month = month_param
    date_range = Date.parse("%04d-%02d-01" % [@year, @month]).all_month
    @transactions = Transaction
      .includes(:vendor)
      .where(date: date_range)
      .order(date: :asc)
    @chart = Chart.new(
      "Monthly report",
      date_range,
      @transactions.group(:date).sum(:debit).to_a
    )
  end

  # GET /reports/yearly
  def yearly
    @year = year_param
    date_range = Date.parse("%04d-01-01" % @year).all_year
    @transactions = Transaction
      .includes(:vendor)
      .where(date: date_range)
      .order(date: :asc)
  end

  # GET /reports/vendors
  def vendors
    @vendor_transaction_amounts = Transaction
      .where.not(vendor_id: nil)
      .group(:vendor)
      .order(sum_debit: :desc)
      .sum(:debit)
  end

  private

  def month_param
    params.require(:month).to_i
  end

  def year_param
    params.require(:year).to_i
  end

  def redirect_to_index
    redirect_to reports_path
  end
end
