require_relative "view"
require "pry"

class MapIndexView < View
  def initialize(window=nil)
    @currently_selected_level = 0
    super(window)
  end

  def draw
    lines = map_file_list

    lines.each_with_index do |line, index|
      if index == @currently_selected_level
        line.sub!("  ", "->")
      end

      # setpos sets cursor at y, x coordinate
      @window.setpos(index, 1)
      @window.addstr(line)
    end

    # apply changes to window
    @window.refresh
  end

  def map_file_list
    Dir["maps/*"].select{ |f| File.file? f }.map{ |f| "  |" + File.basename(f) }
  end

  def handle_input(char)
    if recognized_input?(char)
      move_cursor(char)
    end
  end

  def move_cursor(char)
    if char == "j" && @currently_selected_level < map_file_list.length - 1
      @currently_selected_level += 1
    elsif char == "k" && @currently_selected_level > 0
      @currently_selected_level -= 1
    end

    draw
  end

  def recognized_input?(char)
    ["j", "k"].include?(char)
  end
end
