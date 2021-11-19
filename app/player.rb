class Player
  attr_reader :y, :x

  def initialize(y=0, x=0)
    @y = y
    @x = x
    @enterable_tile_types = [GroundTile, GoalTile]
  end

  def display_char
    "@"
  end

  def update_pos(y, x)
    @y = y
    @x = x
  end

  def can_enter?(tile)
    if @enterable_tile_types.include?(tile.class) && tile.occupant.nil?
      true
    else
      false
    end
  end
end
