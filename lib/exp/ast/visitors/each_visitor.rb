module Exp
  class AST
    module Visitors
      class EachVisitor < Visitor
        include Navigation
        attr_reader :block

        def initialize(block)
          @block = block
        end

        def visit(node)
          super
          @block.call(node) if @block
        end
      end
    end
  end
end