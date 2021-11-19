require_relative "tile_type"

class GroundTile < TileType
  def initialize
    @display_char = "*"
  end
end
