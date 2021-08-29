class ReportsController < ApplicationController
  class InvalidParam < StandardError; end
  rescue_from InvalidParam, with: :redirect_to_index

  class Chart
    attr_reader :height, :width, :padding, :date_range, :points

    Line = Struct.new(:x1, :x2, :y1, :y2, :colour)
    Point = Struct.new(:date, :amount)

    def initialize(date_range, points)
      @height = 500
      @width = 800
      @padding = 80
      @date_range = date_range
      @points = points.map { |x, y| Point.new(x, y) }
    end

    def plot_height
      height - 2 * @padding
    end

    def plot_width
      width - 2 * @padding
    end

    def horizontal_line
      y = plot_height + padding
      Line.new(padding, width - padding, y, y, "black")
    end

    def vertical_line
      x = padding
      Line.new(x, x, plot_height + padding, padding, "black")
    end

    def max
      points.map(&:amount).max
    end

    def to_partial_path
      'reports/chart'
    end
  end

  # GET /
  def index
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
    daily_debits = @transactions.group(:date).sum(:debit)
    @max_daily_debit = daily_debits.values.max
    @chart = Chart.new(date_range, daily_debits.to_a)
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
