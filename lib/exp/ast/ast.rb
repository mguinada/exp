require 'exp/ast/visitors'

module Exp
  # The abstract sytanx tree
  class AST
    attr_reader :root

    def initialize(root = nil)
      @root = root
    end

    def accept(visitor)
      root.accept(visitor)
    end

    def evaluate
      nil
    end

    def ==(other)
      self.class == other.class && self.root == other.root
    end

    #Base node
    class Node
      include Visitable

      def literal?
        is_a?(Exp::AST::Literal)
      end
    end
  end
end