require 'exp/ast/visitors'

module Exp
  # The abstract sytanx tree
  class AST
    include Enumerable
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

    def each(&block)
      root.accept(Visitors::EachVisitor.new(block))
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

      def binary?
        is_a?(Exp::AST::BinaryNode)
      end

      def unary?
        is_a?(Exp::AST::UnaryNode)
      end
    end
  end
end