require "pry"
require "curses"
require_relative "map"

# adjust to size of screen and terminal
MAX_WINDOW_HEIGHT = 56
MAX_WINDOW_WIDTH = 200
TOP = 0
LEFT = 0

class Game
  def initialize
    # set of files to test with, add function to read formatted text file to create map
    tiles = [
              [Tile.new(0, 0, Tile::WALL), Tile.new(0, 0, Tile::WALL), Tile.new(0, 0, Tile::WALL), Tile.new(0, 0, Tile::WALL), Tile.new(0, 0, Tile::WALL)],
              [Tile.new(0, 0), Tile.new(0, 0), Tile.new(0, 0), Tile.new(0, 0), Tile.new(0, 0)],
              [Tile.new(0, 0), Tile.new(0, 0), Tile.new(0, 0), Tile.new(0, 0), Tile.new(0, 0)],
              [Tile.new(0, 0), Tile.new(0, 0), Tile.new(0, 0), Tile.new(0, 0), Tile.new(0, 0)],
              [Tile.new(0, 0), Tile.new(0, 0), Tile.new(0, 0), Tile.new(0, 0), Tile.new(0, 0)]
            ]
    # create new map with top row at y=1 and left column at x=2
    # tiles are stored in order dependent 2d array
    @map = Map.new(1, 2, tiles)
    # create main window
    @main_win = full_size_window
    # set initial curses setings
    Curses.init_screen
    # sets curses to not immediately print terminal input to screen
    Curses.noecho
    # stdscr is a predefined window that corresponds to full screen
    # @screen = Curses.stdscr
    # Unknown attributes for curses
    # @screen.scrollok(true)
    # @screen.keypad(true)

    begin
      # https://www.rubydoc.info/gems/curses/Curses.crmode
      # essentially makes it so that any character entered on the keyboard is
      # immediately available without the user having to enter a newline or
      # carriage return
      Curses.crmode

      # until there is more legitimate code this will stay for reference
      # main_win.bkgd("-")
      # sub_win = main_win.subwin(36, 180, 10, 10)
      # sub_win.bkgd("*")
      # main_win.refresh
      # main_win.bkgd("x")
      # sub_win.bkgd("x")
      # sub_win.refresh

      # draw initial map
      draw_map

      while true do
        char = @main_win.getch

        if char == "q"
          @main_win.close
          break
        else
          next
        end
      end
    ensure
      # gracefully close the screen
      Curses.close_screen
    end
  end

  def handle_input
  end

  # maybe move to Map?
  # for updating small sections of the map E.g character movement
  def update_map
  end

  def draw_map
    # each line is a string of display characters
    lines = @map.format_map

    lines.each_with_index do |line, index|
      # setpos sets cursor at y, x coordinate
      @main_win.setpos(@map.top + index, @map.left)
      @main_win.addstr(line)
    end

    @main_win.refresh
  end

  # construct window to contain all other windows
  def full_size_window
    win = Curses::Window.new(MAX_WINDOW_HEIGHT, MAX_WINDOW_WIDTH, TOP, LEFT)
    win.box("|", "-")
    win
  end
end
