class Player
  attr_reader :y, :x

  def initialize(y=0, x=0)
    @y = y
    @x = x
  end

  def display_char
    "@"
  end

  def update_pos(y, x)
    @y = y
    @x = x
  end
end
