module Exp
  class AST
    class UnaryNode < Node
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def ==(other)
        self.class == other.class && self.value == other.value
      end
    end

    class Brackets < UnaryNode
      def eval(ctx)
        value.eval(ctx)
      end
    end

    class Literal < UnaryNode; end

    class Number < Literal
      def eval(ctx)
        value
      end
    end

    class Variable < Literal
      def eval(ctx)
        binded_value = ctx.lookup(value)
        raise UndefinedVariable, "variable #{value} is undefined." if binded_value.nil?
        binded_value
      end
    end
  end
end