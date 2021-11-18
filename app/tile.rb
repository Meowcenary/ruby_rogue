class Tile
  GROUND = :ground
  WALL = :wall

  TYPES = {
    GROUND => "*",
    WALL   => "#"
  }

  attr_reader :display_char
  attr_accessor :occupant

  def initialize(type=GROUND, occupant=nil)
    @occupant = occupant
    @type = type
    @display_char = display_char_from_type(type)
  end

  def self.type_from_display_char(char)
    # returns array with key and value if match which is shifted to get first value
    TYPES.find{ |key, values| values.include?(char) }.shift
  end

  def display_char_from_type(type)
    TYPES[type]
  end

  def display_char
    if @occupant
      @occupant.display_char
    else
      @display_char
    end
  end
end
