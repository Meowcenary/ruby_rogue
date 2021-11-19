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
  # {map_file_path: "", map_str: "", debug: false}
  def initialize(map_file_path)
    # @logger = Logger.new("maze.log", 'weekly')
    # @logger.info("Initializing game")

    # 5x5 map
    # tiles = build_map({string: "**#**\n*****\n#####\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****\n*****"})
    map_file_path ||= "maps/example_map.txt"
    tiles = build_map({file_path: map_file_path})

    # create new map with top row at y=1 and left column at x=2
    # tiles are stored in order dependent 2d array
    @map = Map.new(1, 2, tiles)
    @player = Player.new
    @map.add_object(@player, 1, 1)

    # create main window
    @main_win = full_size_window
    # set initial curses setings
    Curses.init_screen
    # sets curses to not immediately print terminal input to screen
    Curses.noecho
    # sets cursor visibility 0 - invisible, 1 - visible, 2 - very visible
    Curses.curs_set(0)

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

      while true do
        # @logger.info("Waiting for input...")
        char = @main_win.getch
        # @logger.info("Received char: " + char)

        # Endgame
        if char == "q"
          # @logger.info("Closing game")
          @main_win.close
          break
        elsif movement_keys.include?(char)
          handle_movement(char)
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
    # Removing window border for now that I've got more experience with Curses
    # win.box("|", "-")
    win
  end

  def handle_movement(char="")
    # Character movement
    if char == "h"
      new_pos = {y: @player.y, x: @player.x-1}
    elsif char == "j"
      new_pos = {y: @player.y + 1, x: @player.x}
    elsif char == "k"
      new_pos = {y: @player.y - 1, x: @player.x}
    elsif char == "l"
      new_pos = {y: @player.y, x: @player.x + 1}
    end

    if @map.move_object(@player, new_pos[:y], new_pos[:x])
      draw_map
    end
  end

  def movement_keys
    @movement_keys ||= ["h", "j", "k", "l"]
  end
end
