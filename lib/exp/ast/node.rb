module Exp
  class AST
    #Base node
    class Node
      include Visitable

      def each(&block)
        accept(Visitors::Each.new(block))
      end

      def literal?
        is_a?(Exp::AST::Literal)
      end
      alias :terminal? :literal?
    end
  end
end