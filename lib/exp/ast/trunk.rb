module Exp
  # The abstract sytanx tree
  module AST
    class << self
      #alias to Exp::AST::Trunk.new
      def new(nodes = [])
        Trunk.new(nodes)
      end
    end

    #Expressions as ASTs are referenced at this class
    class Trunk
      attr_reader :nodes

      def initialize(nodes)
        @nodes = nodes
      end

      def evaluate
        nil
      end

      def ==(other)
        self.class == other.class && self.nodes == other.nodes
      end
    end
  end
end