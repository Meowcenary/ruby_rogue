require_relative '../app/player'

describe Player do
  let(:player) { Player.new }
  let(:object) { Object.new }
  let(:enterable_tile) { Tile.new(Tile::GROUND) }
  let(:unenterable_tile) { Tile.new(Tile::WALL) }
  let(:enterable_tile_type) { GroundTile.new }
  let(:unenterable_tile_type) { WallTile.new }

  describe "#can_enter?" do
    context "with tile type that can be entered" do
      context "with unoccupied tile" do
        it "returns true" do
          expect(player.can_enter?(enterable_tile)).to eq(true)
        end
      end

      context "with occupied tile" do
        before do
          enterable_tile.occupant = object
        end

        after do
          enterable_tile.occupant = nil
        end

        it "returns false" do
          expect(player.can_enter?(enterable_tile)).to eq(false)
        end
      end
    end

    context "with tile type that can't be entered" do
      it "returns false" do
        expect(player.can_enter?(unenterable_tile)).to eq(false)
      end
    end
  end
end
