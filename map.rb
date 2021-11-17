require_relative "tile"

class Map
  attr_accessor :top, :left, :tiles

  def initialize(top, left, tiles=[[]])
    # height and width might not be necessary
    # @height = height
    # @width = width

    # top left corner of map for determining how to draw everything else relatively
    @top = top
    @left = left
    @tiles = tiles
  end

  def format_map
    # build lines of string from tile display chars
    display_lines = @tiles.map do |line| #.each_cons(@width).map do |line|
      format_line(line)
    end
  end

  # join display chars for one line together
  def format_line(line)
    line.map{ |tile| tile.display_char }.join('')
  end
end
