require_relative "ground_tile"
require_relative "wall_tile"
require_relative "water_tile"
require_relative "goal_tile"

class TileFactory
  def self.build_tile(type=nil)
    case type
    when Tile::GROUND
      GroundTile.new
    when Tile::WALL
      WallTile.new
    when Tile::WATER
      WaterTile.new
    when Tile::GOAL
      GoalTile.new
    else
      # default to ground tile
      GroundTile.new
    end
  end
end
