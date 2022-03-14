require_relative "view"
require_relative "logging"

class MapView < View
  include Logging

  def initialize(window=nil, map=nil, player=nil)
    @map = map
    @player = player
    super(window)
  end

  def draw
    logger.info("Map View: Drawing map")
    # each line is a string of display characters
    lines = @map.format_map

    lines.each_with_index do |line, index|
      # setpos sets cursor at y, x coordinate
      @window.setpos(@map.top + index, @map.left)
      @window.addstr(line)
    end

    # apply changes to window
    @window.refresh
  end

  def handle_input(char)
    if movement_keys.include?(char)
      handle_movement(char)
    end
  end

  def handle_movement(char="")
    # Character movement
    if char == "h"
      new_pos = {y: @player.y, x: @player.x-1}
    elsif char == "j"
      new_pos = {y: @player.y + 1, x: @player.x}
    elsif char == "k"
      new_pos = {y: @player.y - 1, x: @player.x}
    elsif char == "l"
      new_pos = {y: @player.y, x: @player.x + 1}
    end

    if @map.move_object(@player, new_pos[:y], new_pos[:x])
      # draw
    end
  end

  def recognized_input?(char)
    movement_keys.include?(char)
  end

  private

  def movement_keys
    @movement_keys ||= ["h", "j", "k", "l"]
  end
end
