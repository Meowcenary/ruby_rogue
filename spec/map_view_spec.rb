require_relative "../app/map_view"

# This is very difficult to unit test, consider using integration testing here
describe MapView do
  let(:map_double) { double("Map") }
  let(:player_double) { double("Player") }
  let(:window_double) { double("Window") }
  let(:map_view) { MapView.new(window_double, map_double, player_double) }
  let(:movement_keys) { ["h", "j", "k", "l"] }
  let(:move_up_key) { "j" }
  let(:unrecognized_key) { "q" }

  before do
    allow(player_double).to receive(:y).and_return(1)
    allow(player_double).to receive(:x).and_return(1)

    allow(map_double).to receive(:move_object).and_return(true)
    allow(map_double).to receive(:format_map).and_return([[]])
    allow(map_double).to receive(:top).and_return(1)
    allow(map_double).to receive(:left).and_return(1)

    allow(window_double).to receive(:setpos)
    allow(window_double).to receive(:addstr)
    allow(window_double).to receive(:refresh)
  end

  # Just test this manually for now
  # describe "#draw" do
  # end

  describe "#handle_input" do
    context "recognized input" do
      it "calls #handle_movement" do
        # Map#move_object is called in MapView#handle_input
        expect(map_double).to receive(:move_object)
        map_view.handle_input(move_up_key)
      end
    end
  end

  describe "#handle_movement" do
    context "recognized input" do
      it "calls Map#move_object" do
        expect(map_double).to receive(:move_object)
        map_view.handle_movement(move_up_key)
      end
    end
  end

  describe "#recognized_input?" do
    context "input is recognized" do
      it "returns true" do
        expect(map_view.recognized_input?(movement_keys.sample)).to eq(true)
      end
    end

    context "input is not recognized" do
      it "returns false" do
        expect(map_view.recognized_input?(unrecognized_key)).to eq(false)
      end
    end
  end
end
