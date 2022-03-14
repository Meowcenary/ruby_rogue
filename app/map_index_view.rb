require_relative "view"

class MapIndexView < View
  def initialize(window=nil)
    @currently_selected_level = 0
    super(window)
  end

  def draw
    lines = map_file_list

    lines.each_with_index do |line, index|
      if index == @currently_selected_level
        line.sub!("  ", "->")
      end

      # setpos sets cursor at y, x coordinate
      @window.setpos(index, 1)
      @window.addstr(line)
    end

    # apply changes to window
    @window.refresh
  end

  def map_file_list
    Dir["maps/*"].select{ |f| File.file? f }.map{ |f| "  |" + File.basename(f) }
  end

  def handle_input(char)
    # 10 is enter key
    if char == 10 || char == " "
      # raise event that will tell game to switch
      # view from MapIndexView to MapView with the @map variable being built from
      # the file name that is passed as an arg with the event
      # load_map(map_file_path)
    elsif recognized_input?(char)
      move_cursor(char)
    end
  end

  def move_cursor(char)
    if char == "j" && @currently_selected_level < map_file_list.length - 1
      @currently_selected_level += 1
    elsif char == "k" && @currently_selected_level > 0
      @currently_selected_level -= 1
    end

    draw
  end

  def recognized_input?(char)
    # 10 is enter key
    [10, " ", "j", "k"].include?(char)
  end
end
