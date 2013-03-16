module Exp
  class AST
    module Visitors
      class Notation < Visitor
        #include Navigation

        def initialize(notation)
          @notation = notation
          @exp = ''
        end

        def visit_binary_node(node)
          @exp << case @notation.to_sym
                  when :postfix
                    postfix_node(node)
                  when :infix
                    infix_node(node)
                  else
                    raise ArgumentError, 'notation must be :infix of :postfix'
                  end
          ''
        end

        def visit_unary_node(node)
          node.value.to_s
        end

        def infix_node(node)
          "#{visit(node.left)} #{node.symbol} #{visit(node.right)}"
        end

        def postfix_node(node)
          "#{visit(node.left)} #{visit(node.right)} #{node.symbol}"
        end

        def to_s
          @exp.delete(' ').split('').join(' ')
        end
      end
    end
  end
end