#!/usr/bin/env ruby

require_relative "app/game"

map_file_path = ARGV[0]
Game.new(map_file_path)
