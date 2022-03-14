require_relative "logging"

class View
  include Logging

  def initialize(window=nil)
    @window = window
  end

  def draw(lines=[])
    lines.each_with_index do |line, index|
      # setpos sets cursor at y, x coordinate
      @window.setpos(1, 1)
      @window.addstr(line)
    end

    @window.refresh
  end

  def clear
    logger.info("View: window clearing")
    @window.clear
  end

  def recongized_input?
    []
  end
end
