module Gates
  class ApiVersion
    attr_accessor :id, :gates, :predecessor

    def enabled?(gate_name)
      if gates.include?(gate_name)
        true
      elsif !predecessor.nil?
        # recurse to check list of all gates less than or equal to this api
        # version
        !!predecessor.enabled?(gate_name)
      else
        false
      end
    end
  end
end