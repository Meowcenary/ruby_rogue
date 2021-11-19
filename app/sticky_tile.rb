# WIP - after observers are tested conditions will be added
# require_relative "tile_type"
#

class StickyTile
  EVENT_STICKY_ENTERED = :event_sticky_entered

  def initialize
  end

  def display_char
    "S"
  end

  def on_enter(entity)
    [{entity: entity, name: EVENT_STICKY_ENTERED}]
  end
end
