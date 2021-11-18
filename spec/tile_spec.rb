require_relative '../app/tile'

describe Tile do
  let(:ground_tile) { Tile.new }
  let(:ground_display_char) { "*" }
  let(:wall_tile) { Tile.new(Tile::WALL) }
  let(:wall_display_char) { "#" }

  describe "#display_char" do
    it "returns correct display character" do
      expect(ground_tile.display_char).to eq(ground_display_char)
      expect(wall_tile.display_char).to eq(wall_display_char)
    end
  end
end
