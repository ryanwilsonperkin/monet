class ReportsController < ApplicationController
  class InvalidParam < StandardError; end
  rescue_from InvalidParam, with: :redirect_to_index

  # GET /
  def index
  end

  # GET /reports/monthly
  def monthly
    @year = year_param
    @month = month_param
    @transactions = Transaction
      .where(date: Date.parse("%04d-%02d-01" % [@year, @month]).all_month)
      .order(date: :desc)
  end

  private

  def month_param
    default = Time.zone.now.month
    params[:month].to_i.tap do |month|
      return default if month.zero?
      raise InvalidParam unless (1..12).include? month
    end
  end

  def year_param
    default = Time.zone.now.year
    params[:year].to_i.tap do |year|
      return default if year.zero?
      raise InvalidParam unless (1000..3000).include? year
    end
  end

  def redirect_to_index
    redirect_to reports_path
  end
end
