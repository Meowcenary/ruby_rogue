require_relative "../map_builder"

class MapBuilderSpec
  include MapBuilder
end

describe MapBuilder do
  let(:map_builder) { MapBuilderSpec.new }
  let(:line_str) { "*****" }
  let(:map_str) { (line_str + "\n")*5 }
  let(:empty_map) { [[]] }
  let(:file_double) { double("File") }
  let(:file_path) { "file_path" }

  describe "#build_map" do
    context "no params" do
      it "returns an empty 2d array" do
        expect(map_builder.build_map).to eq(empty_map)
      end
    end

    context "file param passed" do
      it "calls build_from_file" do
        expect(map_builder).to receive(:build_from_file)
        map_builder.build_map({file_path: file_path})
      end
    end

    context "string param passed" do
      it "calls build_from_string" do
        expect(map_builder).to receive(:build_from_string)
        map_builder.build_map({string: line_str})
      end
    end

    context "nil passed for params" do
      it "returns an empty 2d array" do
        expect(map_builder.build_map(nil)).to eq(empty_map)
      end
    end
  end

  describe "#build_from_file" do
    before do
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:open).with(file_path).and_return(file_double)
      allow(file_double).to receive(:close)
      allow(file_double).to receive(:read).and_return(map_str)
    end

    it "builds 2d array of tiles with correct types" do
      expect(File).to receive(:exist?).with(file_path)
      expect(File).to receive(:open).with(file_path)
      expect(file_double).to receive(:read)

      map = map_builder.build_from_file(file_path)

      # check that all tiles were generated
      expect(map.length).to eq(5)
      expect(map[0].length).to eq(5)

      # check that each line has the correct display chars
      map.each do |line|
        line_display_chars = line.map(&:display_char).join("")
        expect(line_display_chars).to eq(line_str)
      end
    end
  end

  describe "#build_from_string" do
    it "builds 2d array of tiles with correct types" do
      map = map_builder.build_from_string(map_str)

      # check that all tiles were generated
      expect(map.length).to eq(5)
      expect(map[0].length).to eq(5)

      # check that each line has the correct display chars
      map.each do |line|
        line_display_chars = line.map(&:display_char).join("")
        expect(line_display_chars).to eq(line_str)
      end
    end
  end

  describe "#build_line_from_string" do
    it "builds array of tiles with correct types" do
      line = map_builder.build_line_from_string(line_str)
      line_display_chars = line.map(&:display_char).join("")

      expect(line_display_chars).to eq(line_str)
    end
  end
end
