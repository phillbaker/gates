module Gates
  class Manifest
    attr_accessor :version_map

    def initialize(manifest_hash)
      versions = []
      # iterate backward through the versions to be able to associate the
      # predecessor with each
      manifest_hash['versions'].reverse.each do |version_info|
        version = ApiVersion.new
        version.id = version_info['id']
        version.gates = version_info['gates'].map do |gate_info|
          gate = Gate.new
          gate.name = gate_info['name']
          gate
        end
        version.predecessor = versions.first

        versions << version
      end

      self.version_map = {}
      versions.each do |version|
        version_map[version.id] = version
      end
    end

    def [](version_id)
      version_map[version_id]
    end
  end
end