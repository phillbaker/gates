require "spec_helper"

require "spec_helper"

describe Gates::ApiVersion do
  describe "#enabled?" do
    let(:initial_version) do
      version = Gates::ApiVersion.new
      version.id = "2016-01-29"
      gate = Gates::Gate.new
      gate.name = "allows_foo"
      version.gates = [gate]
      version
    end
    let(:later_version) do
      version = Gates::ApiVersion.new
      version.id = "2016-01-30"
      gate = Gates::Gate.new
      gate.name = "allows_bar"
      version.gates = [gate]
      version.predecessor = initial_version
      version
    end

    context "without predecessor" do
      it "is true for existing gates" do
        expect(initial_version.enabled?("allows_foo")).to be_truthy
      end

      it "is false for non-existing gates" do
        expect(initial_version.enabled?("allows_cat")).to be_falsey
      end
    end

    context "with predecessor" do
      it "is true for existing gates" do
        expect(later_version.enabled?("allows_bar")).to be_truthy
      end

      it "is true for predecessor existing gates" do
        expect(later_version.enabled?("allows_foo")).to be_truthy
      end

      it "is false for non-existing gates" do
        expect(later_version.enabled?("allows_cat")).to be_falsey
      end
    end
  end
end