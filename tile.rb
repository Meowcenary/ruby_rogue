class Tile
  GROUND = "GROUND"
  WALL = "WALL"

  attr_reader :display_char#:y, :x,
  attr_accessor :occupant

  def initialize(type=GROUND, occupant=nil)#y, x, type=GROUND, occupant=nil)
    # # these might be unnecessary
    # @y = y
    # @x = x
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
