module Exp
  module AST
    class UnaryNode
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def ==(other)
        self.class == other.class && self.value == other.value
      end
    end

    class ValueNode < UnaryNode; end
    class Number < ValueNode; end
    class Brackets < UnaryNode; end
  end
end