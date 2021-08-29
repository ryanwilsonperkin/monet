class ReportsController < ApplicationController
  class InvalidParam < StandardError; end
  rescue_from InvalidParam, with: :redirect_to_index

  class Chart
    include ActionView::Helpers::NumberHelper
    attr_reader :title, :height, :width, :x_padding, :y_padding, :date_range, :points

    Line = Struct.new(:x1, :x2, :y1, :y2, :colour)
    Label = Struct.new(:x, :y, :text)
    Point = Struct.new(:chart, :date, :amount) do
      include ActionView::Helpers::NumberHelper

      def radius
        4
      end

      def title
        "#{date}: #{number_to_currency(amount)}"
      end

      def cx
        chart.plot_width / chart.date_range.count * date.day
      end

      def cy
        chart.plot_height - (chart.plot_height / chart.max * amount)
      end
    end

    def initialize(title, date_range, points)
      @title = title
      @height = 500
      @width = 800
      @x_padding = 80
      @y_padding = 20
      @date_range = date_range
      @points = points.map { |x, y| Point.new(self, x, y) }
    end

    def plot_height
      height - 2 * y_padding
    end

    def plot_width
      width - 2 * x_padding
    end

    def horizontal_line
      Line.new(0, plot_width, plot_height, plot_height, "black")
    end

    def vertical_line
      Line.new(0, 0, 0, plot_height, "black")
    end

    def max
      points.map(&:amount).max
    end

    def x_labels
      date_range.step(8).map do |date|
        Label.new(
          x_padding + (plot_width / date_range.count) * date.day,
          height,
          date.day,
        )
      end
    end

    def y_labels
      [0, max/2, max].map do |amount|
        Label.new(
          x_padding - 10,
          height - amount / max * plot_height - y_padding,
          number_to_currency(amount),
        )
      end
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
    @chart = Chart.new("Monthly report", date_range, daily_debits.to_a)
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
