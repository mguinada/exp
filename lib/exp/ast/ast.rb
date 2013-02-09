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

    def each(&block)
      root.accept(Visitors::Each.new(block))
    end

    def ==(other)
      self.class == other.class && self.root == other.root
    end

    def print(opts = {})
      grapher = grapher(opts)
      grapher.print
      grapher
    end

    def grapher(opts = {})
      visitor = case opts.fetch(:engine, 'ascii').to_s
                when 'graphviz'
                  Visitors::GraphVizGrapher.new
                else
                  Visitors::AsciiGrapher.new
                end

      root.accept(visitor)
      visitor
    end

    #Base node
    class Node
      include Visitable

      def literal?
        is_a?(Exp::AST::Literal)
      end
      alias :terminal? :literal?

      def binary?
        is_a?(Exp::AST::BinaryNode)
      end

      def unary?
        is_a?(Exp::AST::UnaryNode)
      end
    end
  end
end