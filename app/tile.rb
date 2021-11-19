require "observer"

include Observable

class Tile
  attr_reader :type

  # this is smelly...
  GROUND = :ground
  WALL   = :wall
  WATER  = :water
  GOAL   = :goal

  TYPES = {
    GROUND => ".",
    WALL   => "#",
    WATER  => "~",
    GOAL   => "$"
  }

  attr_accessor :occupant

  def initialize
  end

  def self.type_from_display_char(char)
    # returns array with key and value if match which is shifted to get first value
    TYPES.key(char)
  end

  def display
    if @occupant
      @occupant.display_char
    else
      display_char
    end
  end

  # if any events occur notify observer
  def on_enter(entity)
    ## This should be implemented in the subclasses
    return
  end

  def display_char
    ## This should be implemented in the subclasses
    return
  end
end
