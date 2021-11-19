require_relative "tile_type"

class WallTile < TileType
  def initialize
    @display_char = "#"
  end
end
