class Event
  attr_reader :name, :args

  def initialize(name=nil, args={})
    # function that should be called on handler class
    # :goal_tile_entered
    @name = name
    # arguments that are passed along with event
    # {entity: entity}
    @args = args
  end
end
