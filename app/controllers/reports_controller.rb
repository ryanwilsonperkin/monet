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
      @transactions.group(:date).sum(:debit).to_a,
      -> (date) { date.strftime("%d") },
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
    @chart = Chart.new(
      "Yearly report",
      date_range,
      @transactions.group(:date).sum(:debit).to_a,
      -> (date) { date.strftime("%m-%d") },
    )
  end

  # GET /reports/vendors
  def vendors
    @vendor_transactions = Transaction
      .where.not(vendor_id: nil)
      .where.not(debit: nil)
      .joins(:vendor)
      .group(:vendor_id)
      .pluck(
        Vendor.arel_table[:name],
        Transaction.arel_table[:id].count,
        Transaction.arel_table[:debit].sum,
      )
      .sort_by(&:last)
      .reverse
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
