require_relative '../app/tile'
require_relative '../app/ground_tile'
require_relative '../app/wall_tile'

describe Tile do
  let(:ground_tile) { GroundTile.new }
  let(:ground_display_char) { "." }
  let(:wall_tile) { WallTile.new }
  let(:wall_display_char) { "#" }
  let(:player_double) { double("Player") }
  let(:player_display_char) { "@" }

  describe "#display" do
    before do
      allow(player_double).to receive(:display_char).and_return(player_display_char)
    end

    context "tile is not occupied" do
      it "returns the tile's display char" do
        expect(ground_tile.display).to eq(ground_display_char)
      end
    end

    context "tile is occupied" do
      before do
        ground_tile.occupant = player_double
      end

      after do
        ground_tile.occupant = nil
      end

      it "returns the occupant's display char" do
        expect(ground_tile.display).to eq(player_display_char)
      end
    end
  end

  describe "#display_char" do
    it "returns correct display character" do
      expect(ground_tile.display_char).to eq(ground_display_char)
      expect(wall_tile.display_char).to eq(wall_display_char)
    end
  end
end
