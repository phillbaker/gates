require "spec_helper"

describe Gates do
  it "has a version number" do
    expect(Gates::VERSION).not_to be nil
  end

  describe ".for" do
    let(:manifest_data) {
      {
        "versions" => [
          {
            "id" => "2016-01-30",
            "gates" => [
              "name" => "allows_special"
            ]
          },
        ]
      }
    }
    let(:manifest) { Gates::Manifest.new(manifest_data) }

    it "returns an api version" do
      Gates.manifest = manifest
      expect(Gates.for("2016-01-30")).to be_a(Gates::ApiVersion)
    end

    it "returns nil if no api version exists"
    it "raises on uninitialized"
  end
end
