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

      def eval(ctx, operator)
        left.eval(ctx).send(operator, right.eval(ctx))
      end
    end

    class Addition < BinaryNode
      def initialize(left, right)
        super('+', left, right)
      end

      def eval(ctx)
        super(ctx, :+)
      end
    end

    class Subtraction < BinaryNode
      def initialize(left, right)
        super('-', left, right)
      end

      def eval(ctx)
        super(ctx, :-)
      end
    end

    class Multiplication < BinaryNode
      def initialize(left, right)
        super('*', left, right)
      end

      def eval(ctx)
        super(ctx, :*)
      end
    end

    class Division < BinaryNode
      def initialize(left, right)
        super("\/", left, right)
      end

      def eval(ctx)
        super(ctx, :/)
      end
    end

    class Exponentiation < BinaryNode
      def initialize(left, right)
        super('^', left, right)
      end

      def eval(ctx)
        super(ctx, :**)
      end
    end
  end
end