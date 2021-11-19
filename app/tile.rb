require_relative "ground_tile"
require_relative "wall_tile"
require_relative "water_tile"

class Tile
  attr_reader :type

  GROUND = GroundTile.new
  WALL =  WallTile.new
  WATER = WaterTile.new
  TYPES = [GROUND, WALL, WATER]

  attr_accessor :occupant

  def initialize(type=GROUND, occupant=nil)
    @occupant = occupant
    @type = type
  end

  def self.type_from_display_char(char)
    # returns array with key and value if match which is shifted to get first value
    TYPES.find{ |type| type.display_char == char }
  end

  def display_char
    if @occupant
      @occupant.display_char
    else
      @type.display_char
    end
  end
end
