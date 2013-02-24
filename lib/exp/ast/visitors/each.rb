module Exp
  class AST
    module Visitors
      class Each < Visitor
        include Navigation
        attr_reader :block

        def initialize(block)
          @block = block
        end

        def visit(node)
          if @block
            @block.call(node)
            super
          else
            Enumerator.new(node, :each)
          end
        end
      end
    end
  end
end