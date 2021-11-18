require "curses"

require_relative "map"
require_relative "player"
require_relative "map_builder"

include MapBuilder

# adjust to size of screen and terminal
MAX_WINDOW_HEIGHT = 56
MAX_WINDOW_WIDTH = 200
TOP = 0
LEFT = 0

class Game
  def initialize
    # @logger = Logger.new("maze.log", 'weekly')
    # @logger.info("Initializing game")

    # 5x5 map
    # tiles = build_map({string: "**#**\n*****\n#####\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****"})
    tiles = build_map({file_path: "maps/example_map.txt"})

    # create new map with top row at y=1 and left column at x=2
    # tiles are stored in order dependent 2d array
    @map = Map.new(1, 2, tiles)
    @player = Player.new
    @map.add_object(@player, 0, 0)

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

      # draw initial map
      draw_map

      #
      # handle user input
      # this should be moved to a handler function or refactored into event handler pattern
      while true do
        # @logger.info("Waiting for input...")
        char = @main_win.getch
        # @logger.info("Received char: " + char)

        # Endgame
        if char == "q"
          # @logger.info("Closing game")
          @main_win.close
          break
        # Character movement
        elsif char == "h"
          if @map.move_object(@player, @player.y, @player.x - 1)
            draw_map
          end
        elsif char == "j"
          if @map.move_object(@player, @player.y + 1, @player.x)
            draw_map
          end
        elsif char == "k"
          if @map.move_object(@player, @player.y - 1, @player.x)
            draw_map
          end
        elsif char == "l"
          if @map.move_object(@player, @player.y, @player.x + 1)
            draw_map
          end
        # Unrecognized input
        else
          next
        end
      end
    ensure
      # @logger.info("Exiting program")
      # gracefully close the screen
      Curses.close_screen
    end
  end

  # def handle_input
  # end

  # maybe move to Map?
  # for updating small sections of the map E.g character movement
  # def update_map
  # end

  def draw_map
    # @logger.info("Drawing map")
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
