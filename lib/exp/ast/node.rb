module Exp
  class AST
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