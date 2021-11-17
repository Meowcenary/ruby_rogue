class Tile
  GROUND = "GROUND"
  WALL = "WALL"

  attr_reader :y, :x, :display_char

  def initialize(y, x, type=GROUND, occupant=nil)
    # these might be unnecessary
    @y = y
    @x = x

    @type = type
    @occupant = occupant
  end

  def display_char
    if @occupant
      @occupant.display_char
    elsif @type == GROUND
      "*"
    elsif @type == WALL
      "#"
    end
  end
end
