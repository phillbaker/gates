require "spec_helper"

describe Gates::Manifest do
  describe "#initialize" do
    let(:manifest_data) {
      {
        "versions" => [
          {
            "id" => "2016-01-30",
            "gates" => [
              "name" => "allows_bar"
            ]
          },
          {
            "id" => "2016-01-29",
            "gates" => [
              "name" => "allows_foo"
            ]
          },
        ]
      }
    }
    let(:manifest) { Gates::Manifest.new(manifest_data) }

    it "fills the version_map" do
      expect(manifest.version_map.size).to eq 2
    end

    it "sets the api version gates" do
      verison = manifest.version_map["2016-01-30"]
      expect(verison.gates.size).to eq 1
    end

    it "calculates the version predecessor" do
      earlier_version = manifest.version_map["2016-01-30"].predecessor
      expect(earlier_version.id).to eq "2016-01-29"
    end
  end

  describe "#[]"
end