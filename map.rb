require_relative "tile"

class Map
  attr_accessor :top, :left, :tiles

  def initialize(top, left, tiles=[[]])
    # top left corner of map for determining how to draw everything else relatively
    @top = top
    @left = left
    @tiles = tiles
  end

  # as convention all maps are rectangles with a tile for each coordinate
  def width
    @tiles[0].length
  end

  def height
    @tiles.length
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

  # add object to map at coordinate
  # true if successful otherwise false
  def add_object(object, pos_y, pos_x)
    if within_map(pos_y, pos_x)
      #if tile && !tile.occupant
      tile = @tiles[pos_y][pos_x]
      tile.occupant = object
      true
    else
      false
    end
  end

  # move object on map to new coordinate
  # if successful return true otherwise false
  def move_object(object, new_pos_y, new_pos_x)
    if within_map(new_pos_y, new_pos_x)
      start_tile = @tiles[object.y][object.x]
      end_tile = @tiles[new_pos_y][new_pos_x]

      # update tiles to reflect the move
      start_tile.occupant = nil
      end_tile.occupant = object
      # update the object's position for future tracking
      object.update_pos(new_pos_y, new_pos_x)
      true
    else
      false
    end
  end

  private

  def within_map(pos_y, pos_x)
    (0 <= pos_y && pos_y < height) && (0 <= pos_x && pos_x < width)
  end

  # check if position to move to is valid
  # def valid_position?
  # end
end
