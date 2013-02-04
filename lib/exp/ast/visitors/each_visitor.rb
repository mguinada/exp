module Exp
  class AST
    module Visitors
      class EachVisitor < Visitor
        attr_reader :block
        def initialize(block)
          @block = block
        end

        def visit_node(node)
          block.call(node)
        end
      end
    end
  end
end