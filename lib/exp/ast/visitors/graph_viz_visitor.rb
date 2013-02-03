module Exp
  class AST
    module Visitors
      class GraphVizVisitor < Visitor
        attr_reader :graph

        def initialize
          raise 'Depends on the ruby-graphviz gem' unless defined?(GraphViz)
          @graph = GraphViz.new(:G, :type => :digraph)
        end

        def visit_binary_node(node)
          graph_binary_node(@graph.add_nodes(node.symbol), node)
        end

        def visit_brackets(node)
          visit(node.value)
        end

        def visit_unary_node(node)
          @graph.add_nodes(node.value.to_s)
        end

        def write(opts = {png: 'graph.png'})
          @graph.output(opts)
        end

        private
        def graph_binary_node(graph_viz_node, node)
          @graph.add_edges(graph_viz_node, visit(node.left), label: 'l', dir: 'back')
          @graph.add_edges(graph_viz_node, visit(node.right), label: 'r', dir: 'back')
          graph_viz_node
        end
      end
    end
  end
end