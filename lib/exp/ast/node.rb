module Exp
  class AST
    #Base node
    class Node
      include Visitable

      def literal?
        is_a?(Exp::AST::Literal)
      end
      alias :terminal? :literal?
    end
  end
end