module Exp
  class AST
    module Visitors
      class AsciiGrapher < Visitor
        attr_reader :graph

        def initialize
          @indentation = 0
          @graph = []
        end

        def visit_unary_node(node)
          graph_node("#{underscore(node.class.name)} [#{node.value}]")
        end

        def visit_brackets(node)
          graph_node("#{underscore(node.class.name)} [(...)]")
          indent
          visit(node.value)
          dedent
        end

        def visit_binary_node(node)
          graph_node("#{underscore(node.class.name)} [#{node.symbol}]")
          indent
          visit(node.left)
          visit(node.right)
          dedent
        end

        def print
          puts graph.join("\n")
        end

        def inspect
          @graph
        end

        private
        def graph_node(str)
          @graph << ["#{' ' * @indentation}#{str}"]
        end

        def indent
          @indentation += 2
        end

        def dedent
          @indentation -= 2
        end
      end
    end
  end
end