module Gates
  class Gate
    attr_accessor :name

    def ==(other_name)
      name.to_s == other_name.to_s
    end
  end
end