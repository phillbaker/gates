require "yaml"

require "gates/api_version"
require "gates/gate"
require "gates/manifest"
require "gates/version"

module Gates
  Error = Class.new(StandardError)
  UninitializedError = Class.new(Gates::Error)

  class<<self
    attr_accessor :manifest

    def load(file_path)
      hash = Psych.parse_file(file_path)
      @manifest = Manifest.new(hash)
    end

    def for(version_id)
      raise UninitializedError unless @manifest

      @manifest[version_id]
    end
  end
end
