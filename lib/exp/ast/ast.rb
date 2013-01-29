module Exp
  # The abstract sytanx tree
  class AST
    attr_reader :root

    def initialize(root = nil)
      @root = root
    end

    def evaluate
      nil
    end

    def ==(other)
      self.class == other.class && self.root == other.root
    end

    #Base node
    class Node
    end
  end
end