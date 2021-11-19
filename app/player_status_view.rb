require_relative "view"

class PlayerStatusView < View
  def initialize(window=nil, player=nil)
    @player = player
    super(window)
  end

  def draw
    lines = ["This is the player status view. I hope you enjoy it."]

    lines.each_with_index do |line, index|
      # setpos sets cursor at y, x coordinate
      @window.setpos(1, 1)
      @window.addstr(line)
    end

    @window.refresh
  end

  def recongized_input?
    []
  end
end
