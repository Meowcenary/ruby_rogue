require_relative "view"

class LevelScoreView < View
  def initialize(window=nil, game=nil)
    @game = game
    super(window)
  end

  def draw
    lines = ["Turns used: #{@game.turns}"]

    lines.each_with_index do |line, index|
      # setpos sets cursor at y, x coordinate
      @window.setpos(1, 1)
      @window.addstr(line)
    end

    @window.refresh
  end
end
