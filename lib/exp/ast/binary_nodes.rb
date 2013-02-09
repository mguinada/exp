module Exp
  class AST
    #Base class for all binary nodes
    class BinaryNode < Node
      attr_reader :symbol, :left, :right

      def initialize(symbol, left, right)
        @symbol, @left, @right = symbol, left, right
      end

      def ==(other)
        self.class == other.class && self.left == other.left && self.right == other.right
      end
    end

    class Addition < BinaryNode
      def initialize(left, right)
        super('+', left, right)
      end
    end

    class Subtraction < BinaryNode
      def initialize(left, right)
        super('-', left, right)
      end
    end

    class Multiplication < BinaryNode
      def initialize(left, right)
        super('*', left, right)
      end
    end

    class Division < BinaryNode
      def initialize(left, right)
        super("\/", left, right)
      end
    end

    class Exponentiation < BinaryNode
      def initialize(left, right)
        super('^', left, right)
      end
    end
  end
end