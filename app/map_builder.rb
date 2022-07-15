module MapBuilder
  LINE_DIVIDER = "\n"

  def build_map(params={file_path: "", string: ""})
    if params && params[:file_path] && !params[:file_path].empty?
      build_from_file(params[:file_path])
    elsif params && params[:string] && !params[:string].empty?
      build_from_string(params[:string])
    else
      [[]]
    end
#  rescue
  end

  # read file at path and build level from content
  def build_from_file(file_path)
    if File.exist?(file_path)
      file = File.open(file_path)
      tiles = build_from_string(file.read)
      file.close()
      tiles
    else
      [[]]
    end
  end

  # takes string of new line separated values
  # representing lines of a level
  # returns 2d array of tiles to be used by Map
  # on failure returns nil
  def build_from_string(level_str)
    lines = level_str.split(LINE_DIVIDER)

    lines.map do |line|
      build_line_from_string(line)
    end
  end

  # takes string of chars representing a line of the level
  # returns array of tiles for use in 2d array
  def build_line_from_string(line_str)
    line_str.split('').map do |char|
      type = Tile.type_from_display_char(char)
      tile = TileFactory.build_tile(type)
      # TODO need to pass map object as an argument to build map - in order for that to happen tile building
      # needs to happen immediately after Map#initialize, but not within it
      # add map as observer to tile
      tile.add_observer(self, :tile_entered)
      tile
    end
  end
end
