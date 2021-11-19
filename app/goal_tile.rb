require_relative "tile"
require_relative "event"

class GoalTile < Tile
  def initialize
  end

  def on_enter(entity)
    changed
    notify_observers(entity, self)
  end

  def display_char
    "$"
  end
end
