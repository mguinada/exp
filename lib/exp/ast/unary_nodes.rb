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

    class Brackets < UnaryNode; end
    class Number < UnaryNode; end
    class Variable < UnaryNode; end
  end
end