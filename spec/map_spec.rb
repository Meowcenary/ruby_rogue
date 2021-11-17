require_relative '../map'
require 'pry'

describe Map do
  let(:height) { 5 }
  let(:width) { 5 }
  let(:tiles) { [single_line, single_line, single_line, single_line, single_line] }
  let(:single_line) { 5.times.map{ |i| Tile.new(0, i) } }
  let(:map) { Map.new(height, width, tiles) }

  describe "#format_map" do
    it "returns an array of strings for rendering" do
      expect(map.format_map).to eq(["*****", "*****", "*****", "*****", "*****"])
    end
  end

  describe "#format_line" do
    it "returns a line of characters for rendering" do
      expect(map.format_line(single_line)).to eq("*****")
    end
  end
end
