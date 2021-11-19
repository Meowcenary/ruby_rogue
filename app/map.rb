require "observer"

require_relative "tile"
require_relative "map_builder"
require_relative "tile_factory"
require_relative "event"

class Map
  include Observable
  include MapBuilder

  attr_accessor :top, :left, :tiles

  def initialize(top, left, map_params={})
    # top left corner of map for determining how to draw everything else relatively
    @top = top
    @left = left
    # tiles are stored in order dependent 2d array
    @tiles = build_map(map_params)
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
    display_lines = @tiles.map do |line|
      format_line(line)
    end
  end

  # join display chars for one line together
  def format_line(line)
    line.map{ |tile| tile.display }.join('')
  end

  # add object to map at coordinate
  # true if successful otherwise false
  def add_object(object, pos_y, pos_x)
    if within_map(pos_y, pos_x)
      tile = @tiles[pos_y][pos_x]

      if object.can_enter?(tile)
        tile.occupant = object
        object.update_pos(pos_y, pos_x)
        true
      else
        false
      end
    else
      false
    end
  end

  # move object on map to new coordinate
  # if successful return true otherwise false
  def move_object(object, new_pos_y, new_pos_x)
    if within_map(new_pos_y, new_pos_x)
      end_tile = @tiles[new_pos_y][new_pos_x]

      if object.can_enter?(end_tile)
        start_tile = @tiles[object.y][object.x]
        # update tiles to reflect the move
        start_tile.occupant = nil
        end_tile.occupant = object
        # update the object's position for future tracking
        object.update_pos(new_pos_y, new_pos_x)
        # trigger any events that should occur on tile entering
        end_tile.on_enter(object)
        true
      else
        false
      end
    else
      false
    end
  end

  # def goal_tile_entered(entity)
  #   # events = [Event.new(:event_goal_entered, args)]
  #   changed
  #   notify_observers(entity)
  # end

  def tile_entered(entity, tile)
    changed
    notify_observers(entity, tile)
  end

  private

  def within_map(pos_y, pos_x)
    (0 <= pos_y && pos_y < height) && (0 <= pos_x && pos_x < width)
  end
end
