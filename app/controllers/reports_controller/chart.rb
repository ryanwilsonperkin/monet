class ReportsController
  class Chart
    include ActionView::Helpers::NumberHelper
    
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
        chart.x_step_size * date.day
      end
      
      def cy
        chart.plot_height - (chart.y_step_size * amount)
      end
    end
    
    attr_reader :title, :height, :width, :x_padding, :y_padding, :date_range, :points

    def initialize(title, date_range, points)
      @title = title
      @height = 400
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

    def x_steps
      date_range.count
    end

    def x_step_size
      plot_width / x_steps
    end

    def y_step_size
      plot_height / max
    end

    def x_labels
      date_range.step(3).map do |date|
        Label.new(
          x_padding + x_step_size * date.day,
          height,
          date.day,
        )
      end
    end

    def y_labels
      return [] if points.empty?

      [0, max/2, max].map do |amount|
        Label.new(
          x_padding,
          height - y_padding - (amount * y_step_size),
          number_to_currency(amount),
        )
      end
    end

    def to_partial_path
      'reports/chart'
    end
  end
end