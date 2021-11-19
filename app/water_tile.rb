require_relative "tile_type"

class WaterTile < TileType
  def initialize
    @display_char = "~"
  end
end
