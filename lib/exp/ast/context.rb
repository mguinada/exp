  class Context
    def initialize
      @vars = {}
    end

    def bind(vars = {})
      @vars.merge!(symbolize_keys!(vars))
    end

    def lookup(var)
      @vars[var.to_sym]
    end

    private
    #ActiveSupport rip off
    def symbolize_keys!(hash)
      hash.keys.each do |key|
        hash[(key.to_sym rescue key) || key] = hash.delete(key)
      end
      hash
    end
  end
