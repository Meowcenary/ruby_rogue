require "curses"
require "pry"

require_relative "logging"
require_relative "map"
require_relative "player"
require_relative "map_view"
require_relative "map_index_view"
require_relative "level_score_view"
require_relative "player_status_view"

# adjust to size of screen and terminal
MAX_WINDOW_HEIGHT = 56
MAX_WINDOW_WIDTH = 200
TOP = 0
LEFT = 0

class Game
  include Logging
  attr_reader :turns

  def initialize(map_file_path)
    logger.info("Initializing game")

    # create main window
    @main_win = full_size_window

    # create views
    @views = {
              map: nil, # added by load_map
              player_status: PlayerStatusView.new(@main_win, @player, self),
              level_score: LevelScoreView.new(@main_win, self),
              map_index_view: MapIndexView.new(@main_win)
             }

    # create new map with top row at y=1 and left column at x=2
    map_file_path ||= "maps/example_map.txt"
    load_map(map_file_path)

    @current_view = @views[:map_index_view]
    logger.info("Game: Adding observer Game to MapViewIndex with function load map")
    @current_view.add_observer(self, :load_map)

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

      @turns = 0
      @run = true

      while @run do
        @current_view.draw

        logger.info("Game: current_view=#{@current_view.class}")
        logger.info("Game: Waiting for input...")
        char = @main_win.getch
        logger.info("Received char: #{char}")

        ### Handle input
        # End the game
        if char == "q"
          logger.info("Game: Closing game")
          close_game
        # switch view to map
        elsif char == "m"
          logger.info("Game: Switching view to map")
          switch_view(:map)
          # switch view to player status
        elsif char == "p"
          logger.info("Game: Switching view to player status")
          switch_view(:player_status)
        elsif char == "i"
          logger.info("Game: Switching view to map index")
          switch_view(:map_index_view)
        # if not system command, see if the current view recognizes it
        elsif @current_view.recognized_input?(char)
          @current_view.handle_input(char)
          # this needs to be moved into the map view
          # @turns += 1
        # Unrecognized input
        else
          next
        end
      end
    ensure
      logger.info("Game: Exiting program")
      # gracefully close the screen
      Curses.close_screen
    end
  end

  # construct window to contain all other windows
  def full_size_window
    win = Curses::Window.new(MAX_WINDOW_HEIGHT, MAX_WINDOW_WIDTH, TOP, LEFT)
    # Removing window border for now that I've got more experience with Curses
    # win.box("|", "-")
    win
  end

  def tile_entered(entity, tile)
    if entity.is_a?(Player) && tile.is_a?(GoalTile)
      logger.info("Game: Goal tile entered")
      switch_view(:level_score)
    end
  end

  def close_game
    @run = false
  end

  def switch_view(view_id)
    logger.info("Game: clearing #{@current_view.class}")
    @current_view.clear
    logger.info("Game: switching view to view_id=#{view_id}")
    @current_view = @views[view_id]
    logger.info("Game: drawing #{@current_view.class}")
    @current_view.draw
  end

  def map_view_event(event)
    if event == :turn_end
      @turns += 1
    end
  end

  def load_map(map_file_path, open_map=false)
    logger.info("Game: loading map #{map_file_path}")
    # 2d array of Tile objects
    @map = Map.new(1, 2, {file_path: map_file_path})
    @map.add_observer(self, :tile_entered)

    # create player, add to map
    @player ||= Player.new
    @map.add_object(@player, 1, 1)
    # reset turns
    @turns = 0

    # update views
    @views[:map] = MapView.new(@main_win, @map, @player)
    @views[:map].add_observer(self, :map_view_event)

    if open_map
      @current_view.clear
      @current_view = @views[:map]
    end
  end
end
