module Exp
  module AST
    #Base class for all binary nodes
    class BinaryNode
      attr_reader :left, :right

      def initialize(left, right)
        @left, @right = left, right
      end

      def ==(other)
        self.class == other.class && @left = other.left && @right = other.right
      end
    end

    class Addition < BinaryNode; end
    class Subtraction < BinaryNode; end
    class Multiplication < BinaryNode; end
    class Division < BinaryNode; end
  end
end