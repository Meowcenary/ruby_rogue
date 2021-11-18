require_relative '../map'
require 'pry'

describe Map do
  let(:height) { 5 }
  let(:width) { 5 }
  let(:map) { Map.new(height, width, tiles) }

  let(:tiles) { [single_line, single_line, single_line, single_line, single_line] }
  let(:single_line) { 5.times.map{ |i| Tile.new() } }

  let(:player_double){ double("Player") }
  let(:player_y) { 1 }
  let(:player_x) { 1 }
  let(:player_dest_y) { 3 }
  let(:player_dest_x) { 3}

  let(:fake_tile_y) { 5 }
  let(:fake_tile_x) { 5 }

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

  describe "#add_object" do
    context "destination tile exists" do
      after do
        # reset map
        map.tiles[player_y][player_x].occupant = nil
      end

      it "adds object to map" do
        expect(map.add_object(player_double, player_y, player_x)).to eq(true)
      end
    end

    context "destination tile does not exist" do
      it "fails to add object to map" do
        expect(map.add_object(player_double, fake_tile_y, fake_tile_x)).to eq(false)
      end
    end
  end

  describe "#move_object" do
    before do
      allow(player_double).to receive(:y).and_return(player_y)
      allow(player_double).to receive(:x).and_return(player_x)
      allow(player_double).to receive(:update_pos)
    end

    context "destination tile exists" do
      before do
        # add player to map directly
        map.tiles[player_y][player_x].occupant = player_double
      end

      after do
        # reset map
        map.tiles[player_y][player_x].occupant = nil
      end

      it "moves the object" do
        expect(player_double).to receive(:update_pos).with(player_dest_y, player_dest_x)
        expect(map.move_object(player_double, player_dest_y, player_dest_x)).to eq(true)
      end
    end

    context "destination tile does not exists" do
      it "does not move the object" do
        expect(map.move_object(player_double, fake_tile_y, fake_tile_x)).to eq(false)
      end
    end
  end
end
